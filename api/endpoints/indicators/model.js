const {isValid} = require('./validation');
const client = require('../../helpers/pg-client');
const jsonapiHelper = require('../../helpers/jsonapi');
const jsonStat = require('../../helpers/json-stat');
const sdmx = require('../../helpers/sdmx');
const defaultUrlResolver = require('../../helpers/defaultUrlResolver');
const observations = require('../observations/model');
const timeseries = require('../timeseries/model');

const listQuery = 'SELECT * FROM "vIndicators" ORDER BY "dateModified" LIMIT $1 OFFSET $2';
const countQuery = 'SELECT COUNT(*) FROM "vIndicators"';
const existQuery = 'SELECT COUNT(*) FROM  "vIndicators" WHERE id = $1';
const getQuery = 'SELECT * FROM "vIndicators" WHERE id = $1 LIMIT 1';
const getStatus = 'SELECT json_object(keys, values) status FROM (SELECT ARRAY_AGG(name) keys, ARRAY_AGG(symbol) "values" FROM status) s;';

class MissingIndicatorError extends TypeError {}

function format(indicator, urlResolver) {
	const self = urlResolver.resolve(`/indicators/${indicator.id}`);
	return jsonapiHelper.format({
		type: 'indicator',
		...indicator,
		links: {
			self,
			'json-stat': `${self}/json-stat`,
			'sdmx': `${self}/sdmx`
		},
		relationships: {
			observations: {
				links: {
					self: `${self}/observations`
				}
			},
			timeseries: {
				links: {
					self: `${self}/timeseries`
				}
			},
		}
	});
}

module.exports = {
	isValid,
	list: async function(start, count, urlResolver = defaultUrlResolver) {
		return new Promise(async (resolve, reject) => {
			try {
				const [res, countRes] = await client.query(
					[listQuery, count, start],
					countQuery
				);
				resolve({
					length: parseInt(countRes.rows[0].count, 10),
					list: res.rows.map((o) => {
						return format(o, urlResolver);
					})
				});
			} catch (e) {
				reject(e);
			}
		});
	},
	exists: async function(id, throwOnFalse = false) {
		return new Promise(async (resolve, reject) => {
			try {
				this.isValid(id, true);
				const res = await client.query([existQuery, id]);
				const exist = res.rows[0].count > 0;

				if (!exist && throwOnFalse) {
					reject(new MissingIndicatorError(`Indicator '${id}' not found`));
				}

				resolve(exist);
			} catch (e) {
				reject(e);
			}
		});
	},
	get: async function(id, urlResolver = defaultUrlResolver) {
		return new Promise(async (resolve, reject) => {
			try {
				this.isValid(id, true);
				const res = await client.query([getQuery, id]);
				resolve(res.rowCount > 0 ? format(res.rows[0], urlResolver) : undefined);
			} catch (e) {
				reject(e);
			}
		});
	},
	listObservations: async function(id, start, count, urlResolver = defaultUrlResolver, options) {
		return observations.list(start, count, urlResolver, {indicator: id, ...options});
	},
	listTimeseries: async function(id, start, count, urlResolver = defaultUrlResolver, options) {
		return timeseries.list(start, count, urlResolver, {indicator: id, ...options});
	},
	getJSONStat: async function(id, urlResolver = defaultUrlResolver, options) {
		return new Promise(async (resolve, reject) => {
			this.isValid(id, true);
			let [indicator, {list}] = await Promise.all([
				this.get(id, urlResolver),
				observations.list(0, null, urlResolver, {indicator: id})
			]).catch(reject);

			resolve(jsonStat.convert(id, indicator, list));
		});
	},
	getSDMX: async function(id, urlResolver = defaultUrlResolver, options) {
		return new Promise(async (resolve, reject) => {
			this.isValid(id, true);
			let [indicator, {list}, status] = await Promise.all([
				this.get(id, urlResolver),
				observations.list(0, null, urlResolver, {indicator: id}),
				new Promise(async (resolve, reject) => {
					const res = await client.query(getStatus).catch(reject);
					resolve(res.rows[0].status);
				})
			]).catch(reject);

			resolve(sdmx.convert(id, indicator, list, status));
		});
	}
};

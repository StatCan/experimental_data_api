const {Client} = require('pg').native;
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

const indicatorIdValidation = /^[aA-zZ1-9_-]*$/;

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
	list: async function(start, count, urlResolver = defaultUrlResolver) {
		const client = new Client();
		return new Promise(async (resolve, reject) => {
			await client.connect().catch(reject);
			const [res, countRes] = await Promise.all([
				client.query(listQuery, [count, start]),
				client.query(countQuery)
			]).catch(reject);
			client.end();
			resolve({
				length: parseInt(countRes.rows[0].count, 10),
				list: res.rows.map((o) => {
					return format(o, urlResolver);
				})
			});
		});
	},
	isValid: function(id) {
		return indicatorIdValidation.test(id);
	},
	exists: async function(id) {
		const client = new Client();
		return new Promise(async (resolve, reject) => {
			await client.connect().catch(reject);
			const res = await client.query(existQuery, [id]).catch(reject);
			client.end();
			resolve(res.rows[0].count > 0);
		});
	},
	get: async function(id, urlResolver = defaultUrlResolver) {
		const client = new Client();
		return new Promise(async (resolve, reject) => {
			await client.connect().catch(reject);
			const res = await client.query(getQuery, [id]).catch(reject);
			client.end();
			resolve(res.rowCount > 0 ? format(res.rows[0], urlResolver) : undefined);
		});
	},
	listObservations: async function(id, start, count, urlResolver = defaultUrlResolver, options) {
		return observations.list(start, count, urlResolver, {indicator: id, ...options});
	},
	listTimeseries: async function(id, start, count, urlResolver = defaultUrlResolver) {
		return timeseries.list(start, count, urlResolver, {indicator: id});
	},
	getJSONStat: async function(id, urlResolver = defaultUrlResolver, options) {
		return new Promise(async (resolve, reject) => {
			let [indicator, {list}] = await Promise.all([
				this.get(id, urlResolver),
				observations.list(0, null, urlResolver, {indicator: id})
			]).catch(reject);

			resolve(jsonStat.convert(id, indicator, list));
		});
	},
	getSDMX: async function(id, urlResolver = defaultUrlResolver, options) {
		const client = new Client();
		return new Promise(async (resolve, reject) => {
			let [indicator, {list}, status] = await Promise.all([
				this.get(id, urlResolver),
				observations.list(0, null, urlResolver, {indicator: id}),
				new Promise(async (resolve, reject) => {
					await client.connect().catch(reject);
					const res = await client.query(getStatus).catch(reject);
					client.end();
					resolve(res.rows[0].status);
				})
			]).catch(reject);

			resolve(sdmx.convert(id, indicator, list, status));
		});
	}
};

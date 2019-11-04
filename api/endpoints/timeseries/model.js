const client = require('../../helpers/pg-client');
const jsonapiHelper = require('../../helpers/jsonapi');
const defaultUrlResolver = require('../../helpers/defaultUrlResolver');
const observations = require('../observations/model');

const listQuery = ['SELECT * FROM "vTimeseries"', ' ORDER BY indicator LIMIT $1 OFFSET $2'];
const countQuery = 'SELECT COUNT(*) FROM "vTimeseries"';
const existQuery = 'SELECT COUNT(*) FROM  "vTimeseries" WHERE id = $1';
const getQuery = 'SELECT * FROM "vTimeseries" WHERE id = $1 LIMIT 1';

const timeseriesIdValidation = /^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$/;

function format(timeserie, urlResolver) {
	const self = urlResolver.resolve(`/timeseries/${timeserie.id}`);
	const indicator = timeserie.indicator;
	delete timeserie.indicator;
	return jsonapiHelper.format({
		type: 'timeseries',
		...timeserie,
		links: {
			self,
		},
		relationships: {
			observations: {
				links: {
					self: `${self}/observations`
				}
			},
			indicator: {
				links: {
					self: urlResolver.resolve(`/indicators/${indicator}`)
				},
				data: {
					type: 'indicator',
					id: indicator
				}
			}
		}
	});
}

function getFilters(options) {
	let filter = [];

	if (options.indicator) {
		filter.push(`indicator = '${options.indicator}'`);
	}

	return filter.length > 0 ? ` WHERE ${filter.join(' AND ')}` : '';
}

module.exports = {
	list: async function(start, count, urlResolver = defaultUrlResolver, options={}) {
		const filters = getFilters(options);
		return new Promise(async (resolve, reject) => {
			try {
				const [res, countRes] = await client.query(
					[listQuery[0] + filters + listQuery[1], count, start],
					countQuery + filters
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
	isValid: function(id) {
		return timeseriesIdValidation.test(id);
	},
	exists: async function(id) {
		return new Promise(async (resolve, reject) => {
			try {
				const res = await client.query([existQuery, id]);
				resolve(res.rows[0].count > 0);
			} catch (e) {
				reject(e);
			}
		});
	},
	get: async function(id, urlResolver = defaultUrlResolver) {
		return new Promise(async (resolve, reject) => {
			try {
				const res = await client.query([getQuery, id]);
				resolve(res.rowCount > 0 ? format(res.rows[0], urlResolver) : undefined);
			} catch (e) {
				reject(e);
			}
		});
	},
	listObservations: async function(id, start, count, urlResolver = defaultUrlResolver, options) {
		return observations.list(start, count, urlResolver, {timeseries: id, ...options});
	},
};

const {Client} = require('pg').native;
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
		const client = new Client();
		const filters = getFilters(options);
		return new Promise(async (resolve, reject) => {
			await client.connect().catch(reject);
			const [res, countRes] = await Promise.all([
				client.query(listQuery[0] + filters + listQuery[1], [count, start]),
				client.query(countQuery + filters)
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
		return timeseriesIdValidation.test(id);
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
			resolve(format(res.rows[0], urlResolver));
		});
	},
	listObservations: async function(id, start, count, urlResolver = defaultUrlResolver, options) {
		return observations.list(start, count, urlResolver, {timeserie: id, ...options});
	},
};

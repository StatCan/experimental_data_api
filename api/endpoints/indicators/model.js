const {Client} = require('pg');
const jsonapiHelper = require('../../helpers/jsonapi');
const jsonStat = require('../../helpers/json-stat');
const observations = require('../observations/model');

const listQuery = 'SELECT * FROM "vIndicators" ORDER BY "dateModified" LIMIT $1 OFFSET $2';
const countQuery = 'SELECT COUNT(*) FROM "vIndicators"';
const existQuery = 'SELECT COUNT(*) FROM  "vIndicators" WHERE id = $1';
const getQuery = 'SELECT * FROM "vIndicators" WHERE id = $1 LIMIT 1';

const indicatorIdValidation = /^[aA-zZ1-9_-]*$/;

function format(indicator, urlResolver) {
	const self = urlResolver.resolve(`/indicators/${indicator.id}`);
	return jsonapiHelper.format({
		type: 'indicator',
		...indicator,
		links: {
			self,
			'json-stat': `${self}/json-stat`,
			'observations': `${self}/observations`
		}
	});
}

module.exports = {
	list: async function(start, count, urlResolver) {
		const client = new Client();
		return new Promise(async (resolve, reject) => {
			await client.connect().catch(reject);
			const [res, countRes] = await Promise.all([
				client.query(listQuery, [count, start]),
				client.query(countQuery)
			]).catch(reject);
			client.end();
			resolve({
				length: countRes.rows[0].count,
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
	get: async function(id, urlResolver) {
		const client = new Client();
		return new Promise(async (resolve, reject) => {
			await client.connect().catch(reject);
			const res = await client.query(getQuery, [id]).catch(reject);
			client.end();
			resolve(format(res.rows[0], urlResolver));
		});
	},
	listObservations: async function(id, start, count, urlResolver, options) {
		return observations.list(start, count, urlResolver, {indicator: id, ...options});
	},
	getJsonStat: async function(id, urlResolver, options) {
		return new Promise(async (resolve, reject) => {
			let [indicator, {list}] = await Promise.all([
				this.get(id, urlResolver),
				observations.list(0, null, urlResolver, {indicator: id})
			]).catch(reject);

			resolve(jsonStat.convert(id, indicator, list));
		});
	}
};

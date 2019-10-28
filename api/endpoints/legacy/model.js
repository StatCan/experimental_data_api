const {Client} = require('pg').native;
const jsonapiHelper = require('../../helpers/jsonapi');
const defaultUrlResolver = require('../../helpers/defaultUrlResolver');

const listQuery = 'SELECT * FROM "vVectors" LIMIT $1 OFFSET $2';
const countQuery = 'SELECT COUNT(*) FROM "vVectors"';
const existQuery = 'SELECT COUNT(*) FROM  "vVectors" WHERE id = $1';
const getTimeseriesQuery = 'SELECT timeseries FROM "vVectors" WHERE id = $1 LIMIT 1';

const vectorIdValidation = /^\d*$/;

function format(vector, urlResolver) {
	const self = urlResolver.resolve(`/timeseries/${vector.timeseries}`);
	return jsonapiHelper.format({
		type: 'vector',
		...vector,
		links: {
			self
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
		return vectorIdValidation.test(id);
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
	getTimeseries: async function(id, urlResolver) {
		const client = new Client();
		return new Promise(async (resolve, reject) => {
			await client.connect().catch(reject);
			const res = await client.query(getTimeseriesQuery, [id]).catch(reject);
			client.end();
			resolve(res.rowCount > 0 ? res.rows[0].timeseries : undefined);
		});
	}
};

const {Client} = require('pg');
const jsonapiHelper = require('../../helpers/jsonapi');

const listQuery = 'SELECT * FROM "vVectors" LIMIT $1 OFFSET $2';
const countQuery = 'SELECT COUNT(*) FROM "vVectors"';
const existQuery = 'SELECT COUNT(*) FROM  "vVectors" WHERE id = $1';
const getQuery = 'SELECT * FROM "vVectors" WHERE id = $1 LIMIT 1';

const vectorIdValidation = /^\d*$/;

function format(vector, urlResolver) {
	const self = urlResolver.resolve(`/legacy/vectors/${vector.id}`);
	return jsonapiHelper.format({
		type: 'vector',
		...vector,
		links: {
			self
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
	get: async function(id, urlResolver) {
		const client = new Client();
		return new Promise(async (resolve, reject) => {
			await client.connect().catch(reject);
			const res = await client.query(getQuery, [id]).catch(reject);
			client.end();
			resolve(format(res.rows[0], urlResolver));
		});
	}
};

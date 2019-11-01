const client = require('../../helpers/pg-client');
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
	isValid: function(id) {
		return vectorIdValidation.test(id);
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
	getTimeseries: async function(id, urlResolver) {
		return new Promise(async (resolve, reject) => {
			try {
				const res = await client.query([getTimeseriesQuery, id]);
				resolve(res.rowCount > 0 ? res.rows[0].timeseries : undefined);
			} catch (e) {
				reject(e);
			}
		});
	}
};

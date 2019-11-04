const client = require('../../helpers/pg-client');
const jsonapiHelper = require('../../helpers/jsonapi');
const defaultUrlResolver = require('../../helpers/defaultUrlResolver');

const listQuery = 'SELECT * FROM "vVectors" LIMIT $1 OFFSET $2';
const countQuery = 'SELECT COUNT(*) FROM "vVectors"';
const existQuery = 'SELECT COUNT(*) FROM  "vVectors" WHERE id = $1';
const getTimeseriesQuery = 'SELECT timeseries FROM "vVectors" WHERE id = $1 LIMIT 1';

const vectorIdValidation = /^\d*$/;

class InvalidVectorIdError extends TypeError {}
class MissingVectorError extends TypeError {}

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
	isValid: function(id, throwOnFalse = false) {
		const ret = vectorIdValidation.test(id);

		if (!ret && throwOnFalse) {
			throw new InvalidVectorIdError('Invalid vector id');
		}

		return ret;
	},
	exists: async function(id, throwOnFalse = false) {
		return new Promise(async (resolve, reject) => {
			try {
				this.isValid(id, true);
				const res = await client.query([existQuery, id]);
				const exist = res.rows[0].count > 0;

				if (!exist && throwOnFalse) {
					reject(new MissingVectorError(`Vector '${id}' not found`));
				}

				resolve(exist);
			} catch (e) {
				reject(e);
			}
		});
	},
	getTimeseries: async function(id, urlResolver) {
		return new Promise(async (resolve, reject) => {
			try {
				await this.exists(id, true);
				const res = await client.query([getTimeseriesQuery, id]);
				resolve(res.rowCount > 0 ? res.rows[0].timeseries : undefined);
			} catch (e) {
				reject(e);
			}
		});
	}
};

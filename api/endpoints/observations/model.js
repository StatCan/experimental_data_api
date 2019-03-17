const {Client} = require('pg');
const jsonapiHelper = require('../../helpers/jsonapi');

const listQuery = ['SELECT * FROM "vObservations"', ' ORDER BY period DESC, "dateModified" DESC LIMIT $1 OFFSET $2'];
const countQuery = 'SELECT COUNT(*) FROM "vObservations"';
const existQuery = 'SELECT COUNT(*) FROM  "vObservations" WHERE id = $1';
const getQuery = 'SELECT * FROM "vObservations" WHERE id = $1 LIMIT 1';

const dateFormat = {
	year: 'numeric',
	month: '2-digit',
	day: '2-digit'
};

const observationIdValidation = /^\d*$/;

function getFilters(options) {
	let filter = [];

	if (options.indicator) {
		filter.push(`indicator = '${options.indicator}'`);
	}

	if (options.period) {
		let start;
		let end;
		if (options.period.start && options.period.end && options.period.start > options.period.end) {
			start = options.period.end;
			end = options.period.start;
		} else {
			start = options.period.start;
			end = options.period.end;
		}

		if (start) {
			filter.push(`period >= '${start.toLocaleDateString(undefined, dateFormat)}'`);
		}

		if (end) {
			filter.push(`period <= '${end.toLocaleDateString(undefined, dateFormat)}'`);
		}
	}

	return filter.length > 0 ? ` WHERE ${filter.join(' AND ')}` : '';
}

function format(observation, urlResolver) {
	const self = urlResolver.resolve(`/observations/${observation.id}`);
	const newObject = {
		type: 'observation',
		...observation,
		links: {
			self,
			revisions: urlResolver.resolve(`${self}/revisions`),
			notes: urlResolver.resolve(`${self}/notes`)
		}
	};
	newObject.period = newObject.period.toLocaleDateString(undefined, dateFormat);
	return jsonapiHelper.format(newObject);
}

module.exports = {
	list: async function(start, count, urlResolver, options={}) {
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
				length: countRes.rows[0].count,
				list: res.rows.map((o) => {
					return format(o, urlResolver);
				})
			});
		});
	},
	isValid: function(id) {
		return observationIdValidation.test(id);
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

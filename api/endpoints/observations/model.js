const client = require('../../helpers/pg-client');
const jsonapiHelper = require('../../helpers/jsonapi');
const defaultUrlResolver = require('../../helpers/defaultUrlResolver');

const listQuery = ['SELECT * FROM "vObservations"', ' ORDER BY period DESC, "dateModified" DESC LIMIT $1 OFFSET $2'];
const countQuery = 'SELECT COUNT(*) FROM "vObservations"';
const existQuery = 'SELECT COUNT(*) FROM  "vObservations" WHERE id = $1';
const getQuery = 'SELECT * FROM "vObservations" WHERE id = $1 LIMIT 1';

const dateFormat = {
	year: 'numeric',
	month: '2-digit',
	day: '2-digit'
};

const observationIdValidation = /^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$/;

function getFilters(options) {
	let filter = [];

	if (options.indicator) {
		filter.push(`indicator = '${options.indicator}'`);
	}

	if (options.timeseries) {
		filter.push(`timeseries = '${options.timeseries}'`);
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

	if (options.dimensions) {
		for (const [key, values] of Object.entries(options.dimensions)) {
			filter.push(`dimensions ->> '${key}' IN ('${values.join('\',\'')}')`);
		}
	}

	return filter.length > 0 ? ` WHERE ${filter.join(' AND ')}` : '';
}

function format(observation, urlResolver) {
	const self = urlResolver.resolve(`/observations/${observation.id}`);
	const indicator = observation.indicator;
	const timeseries = observation.timeseries;
	delete observation.indicator;
	delete observation.timeseries;
	const newObject = {
		type: 'observation',
		...observation,
		links: {
			self,
		},
		relationships: {
			revisions: {
				links: {
					self: urlResolver.resolve(`${self}/revisions`)
				}
			},
			notes: {
				links: {
					self: urlResolver.resolve(`${self}/notes`)
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
			},
			timeseries: {
				links: {
					self: urlResolver.resolve(`/timeseries/${timeseries}`)
				},
				data: {
					type: 'timeseries',
					id: timeseries
				}
			}
		}
	};
	newObject.period = newObject.period.toLocaleDateString(undefined, dateFormat);
	return jsonapiHelper.format(newObject);
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
		return observationIdValidation.test(id);
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
	}
};

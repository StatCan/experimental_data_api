const {isValid} = require('./validation');
const isIndicatorIdValid = require('../indicators/validation').isValid;
const isTimeseriesIdValid = require('../timeseries/validation').isValid;
const client = require('../../helpers/pg-client');
const {parsePeriod, parseDimensions} = require('../../helpers/parsers');
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

class MissingObservationError extends Error {}

function getFilters(options) {
	let filter = [];

	if (options.indicator && isIndicatorIdValid(options.indicator, true)) {
		filter.push(`indicator = '${options.indicator}'`);
	}

	if (options.timeseries && isTimeseriesIdValid(options.timeseries, true)) {
		filter.push(`timeseries = '${options.timeseries}'`);
	}

	if (options.period) {
		const period = parsePeriod(options.period);
		let start;
		let end;
		if (period.start && period.end && period.start > period.end) {
			start = period.end;
			end = period.start;
		} else {
			start = period.start;
			end = period.end;
		}

		if (start) {
			filter.push(`period >= '${start.toLocaleDateString(undefined, dateFormat)}'`);
		}

		if (end) {
			filter.push(`period <= '${end.toLocaleDateString(undefined, dateFormat)}'`);
		}
	}

	if (options.dimensions) {
		const dimensions = parseDimensions(options.dimensions);
		for (const [key, values] of Object.entries(dimensions)) {
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
	isValid,
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
	exists: async function(id, throwOnFalse = false) {
		return new Promise(async (resolve, reject) => {
			try {
				this.isValid(id, true);
				const res = await client.query([existQuery, id]);
				const exist = res.rows[0].count > 0;

				if (!exist && throwOnFalse) {
					reject(new MissingObservationError(`Observation '${id}' not found`));
				}

				resolve(exist);
			} catch (e) {
				reject(e);
			}
		});
	},
	get: async function(id, urlResolver = defaultUrlResolver) {
		return new Promise(async (resolve, reject) => {
			try {
				this.isValid(id, true);
				const res = await client.query([getQuery, id]);
				resolve(res.rowCount > 0 ? format(res.rows[0], urlResolver) : undefined);
			} catch (e) {
				reject(e);
			}
		});
	}
};

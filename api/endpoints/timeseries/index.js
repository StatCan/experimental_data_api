const timeseries = require('./model');
const pagination = require('jsonapi-pagination');
const {RequestError} = require('express-api-server');
const paginationHelper = require('../../helpers/pagination');
const {parsePeriod, parseDimensions} = require('../../helpers/parsers');

async function validateIndicatorId(req, res, next) {
	try {
		if (!timeseries.isValid(req.params.indicator_id))
			return next(new RequestError(req, 400, 'Invalid indicator id'));

		if (!await timeseries.exists(req.params.indicator_id).catch(next))
			return next(new RequestError(req, 404, `Indicator '${req.params.indicator_id}' not found`));

		next();
	} catch (err) {
		next(err);
	}
}

module.exports = {
	'/': (route, urlResolver) => {
		route
			.get(async (req, res, next) => {
				try {
					let pages = pagination(req);
					let {start, count} = pages.limits;

					const options = {};

					if (req.query.indicator) {
						if (!timeseries.isValid(req.query.indicator))
							return next(new RequestError(req, 400, 'Invalid timeseries id'));

						options.indicator = req.query.indicator;
					}

					let {length, list} = await timeseries.list(start, count, urlResolver, options).catch(next);
					let links = paginationHelper.getLinks(pages, length, urlResolver);

					res.locals.json = {
						links,
						data: list
					};
					next();
				} catch (err) {
					next(err);
				}
			});
	},
	'/:indicator_id': (route, urlResolver) => {
		route
			.get(validateIndicatorId)
			.get(async (req, res, next) => {
				try {
					const indicator = await timeseries.get(req.params.indicator_id, urlResolver).catch(next);
					res.locals.json = {
						data: indicator
					};
					next();
				} catch (err) {
					next(err);
				}
			});
	},
	'/:indicator_id/observations': (route, urlResolver) => {
		route
			.get(validateIndicatorId)
			.get(async (req, res, next) => {
				try {
					const options = {};
					let pages = pagination(req);
					let {start, count} = pages.limits;

					if (req.query.period) {
						try {
							options.period = parsePeriod(req.query.period);
						} catch (e) {
							return next(new RequestError(req, 400, e.message));
						}
					}

					if (req.query.dimensions) {
						try {
							options.dimensions = parseDimensions(req.query.dimensions);
						} catch (e) {
							return next(new RequestError(req, 400, e.message));
						}
					}

					let {length, list} = await timeseries.listObservations(req.params.indicator_id, start, count, urlResolver, options).catch(next);
					let links = paginationHelper.getLinks(pages, length, urlResolver);

					res.locals.json = {
						links,
						data: list
					};
					next();
				} catch (err) {
					next(err);
				}
			});
	}
};

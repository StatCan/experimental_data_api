const timeseries = require('./model');
const pagination = require('jsonapi-pagination');
const {RequestError} = require('express-api-server');
const paginationHelper = require('../../helpers/pagination');

async function validateTimeseriesId(req, res, next) {
	try {
		await timeseries.exists(req.params.indicator_id, true);
		next();
	} catch (err) {
		switch (err.constructor.name) {
		case 'InvalidTimeseriesIdError':
			return next(new RequestError(req, 400, err.message));
		case 'MissingTimeseriesError':
			return next(new RequestError(req, 404, err.message));
		}
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
						options.indicator = req.query.indicator;
					}

					if (req.query.dimensions) {
						options.dimensions = req.query.dimensions;
					}

					let {length, list} = await timeseries.list(start, count, urlResolver, options);
					let links = paginationHelper.getLinks(pages, length, urlResolver);

					res.locals.json = {
						links,
						data: list
					};
					next();
				} catch (err) {
					switch (err.constructor.name) {
					case 'InvalidIndicatorIdError':
						return next(new RequestError(req, 400, err.message));
					}
					next(err);
				}
			});
	},
	'/:indicator_id': (route, urlResolver) => {
		route
			.get(validateTimeseriesId)
			.get(async (req, res, next) => {
				try {
					const indicator = await timeseries.get(req.params.indicator_id, urlResolver);
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
			.get(validateTimeseriesId)
			.get(async (req, res, next) => {
				try {
					const options = {};
					let pages = pagination(req);
					let {start, count} = pages.limits;

					if (req.query.period) {
						options.period = req.query.period;
					}

					if (req.query.dimensions) {
						options.dimensions = req.query.dimensions;
					}

					let {length, list} = await timeseries.listObservations(req.params.indicator_id, start, count, urlResolver, options);
					let links = paginationHelper.getLinks(pages, length, urlResolver);

					res.locals.json = {
						links,
						data: list
					};
					next();
				} catch (err) {
					switch (err.constructor.name) {
					case 'ParsingError':
						return next(new RequestError(req, 400, err.message));
					}
					next(err);
				}
			});
	}
};

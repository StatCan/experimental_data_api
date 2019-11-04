const observations = require('./model');
const pagination = require('jsonapi-pagination');
const {RequestError} = require('express-api-server');
const paginationHelper = require('../../helpers/pagination');
const {parsePeriod, parseDimensions} = require('../../helpers/parsers');

async function validateObservationId(req, res, next) {
	try {
		await observations.exists(req.params.observation_id, true);
		next();
	} catch (err) {
		switch (err.constructor.name) {
		case 'InvalidObservationIdError':
			return next(new RequestError(req, 400, err.message));
		case 'MissingObservationError':
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
					let pages = pagination(req, 10, 1000);
					let {start, count} = pages.limits;

					const options = {};

					if (req.query.indicator) {
						options.indicator = req.query.indicator;
					}

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

					let {length, list} = await observations.list(start, count, urlResolver, options);
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
	'/:observation_id': (route, urlResolver) => {
		route
			.get(validateObservationId)
			.get(async (req, res, next) => {
				try {
					const observation = await observations.get(req.params.observation_id, urlResolver);
					res.locals.json = {
						data: observation
					};
					next();
				} catch (err) {
					next(err);
				}
			});
	},
	'/:observation_id/revisions': (route, urlResolver) => {
		route
			.get(validateObservationId)
			.get(async (req, res, next) => {
				try {
					res.locals.json = {};
					next();
				} catch (err) {
					next(err);
				}
			});
	},
	'/:observation_id/notes': (route, urlResolver) => {
		route
			.get(validateObservationId)
			.get(async (req, res, next) => {
				try {
					res.locals.json = {};
					next();
				} catch (err) {
					next(err);
				}
			});
	}
};

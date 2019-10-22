const indicators = require('./model');
const pagination = require('jsonapi-pagination');
const {RequestError} = require('express-api-server');
const paginationHelper = require('../../helpers/pagination');
const {parsePeriod, parseDimensions} = require('../../helpers/parsers');

async function validateIndicatorId(req, res, next) {
	if (!indicators.isValid(req.params.indicator_id))
		return next(new RequestError(req, 400, 'Invalid indicator id'));

	if (!await indicators.exists(req.params.indicator_id).catch(next))
		return next(new RequestError(req, 404, `Indicator '${req.params.indicator_id}' not found`));

	next();
}

module.exports = {
	'/': (route, urlResolver) => {
		route
			.get(async (req, res, next) => {
				let pages = pagination(req);
				let {start, count} = pages.limits;
				let {length, list} = await indicators.list(start, count, urlResolver).catch(next);
				let links = paginationHelper.getLinks(pages, length, urlResolver);

				res.locals.json = {
					links,
					data: list
				};
				next();
			});
	},
	'/:indicator_id': (route, urlResolver) => {
		route
			.get(validateIndicatorId)
			.get(async (req, res, next) => {
				const indicator = await indicators.get(req.params.indicator_id, urlResolver).catch(next);
				res.locals.json = {
					data: indicator
				};
				next();
			});
	},
	'/:indicator_id/observations': (route, urlResolver) => {
		route
			.get(validateIndicatorId)
			.get(async (req, res, next) => {
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

				let {length, list} = await indicators.listObservations(req.params.indicator_id, start, count, urlResolver, options).catch(next);
				let links = paginationHelper.getLinks(pages, length, urlResolver);

				res.locals.json = {
					links,
					data: list
				};
				next();
			});
	},
	'/:indicator_id/timeseries': (route, urlResolver) => {
		route
			.get(validateIndicatorId)
			.get(async (req, res, next) => {
				let pages = pagination(req);
				let {start, count} = pages.limits;

				let {length, list} = await indicators.listTimeseries(req.params.indicator_id, start, count, urlResolver).catch(next);
				let links = paginationHelper.getLinks(pages, length, urlResolver);

				res.locals.json = {
					links,
					data: list
				};
				next();
			});
	},
	'/:indicator_id/json-stat': (route, urlResolver) => {
		route
			.get(validateIndicatorId)
			.get(async (req, res, next) => {
				const jsonStat = await indicators.getJSONStat(req.params.indicator_id, urlResolver, {url: req.path}).catch(next);
				res.locals.json = jsonStat;
				next();
			});
	},
	'/:indicator_id/sdmx': (route, urlResolver) => {
		route
			.get(validateIndicatorId)
			.get(async (req, res, next) => {
				const sdmx = await indicators.getSDMX(req.params.indicator_id, urlResolver, {url: req.path}).catch(next);
				res.set('Content-Type', 'application/vnd.sdmx.genericdata+xml;version=2.1');
				res.send(sdmx);
				res.end();
			});
	}
};

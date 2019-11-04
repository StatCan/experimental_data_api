const vectors = require('./model');
const pagination = require('jsonapi-pagination');
const {RequestError} = require('express-api-server');
const paginationHelper = require('../../helpers/pagination');

async function validateVectorId(req, res, next) {
	try {
		await vectors.exists(req.params.vector_id, true);
		next();
	} catch (err) {
		switch (err.constructor.name) {
		case 'InvalidVectorIdError':
			return next(new RequestError(req, 400, err.message));
		case 'MissingVectorError':
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
					res.locals.json = {
						id: 'vectors',
						type: 'legacyEndpoint',
						links: {
							self: urlResolver.resolve('/legacy/vectors')
						}
					};
					next();
				} catch (err) {
					next(err);
				}
			});
	},

	'/vectors': (route, urlResolver) => {
		route
			.get(async (req, res, next) => {
				try {
					let pages = pagination(req);
					let {start, count} = pages.limits;
					let {length, list} = await vectors.list(start, count, urlResolver);
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
	'/vectors/:vector_id': (route, urlResolver) => {
		route
			.get(validateVectorId)
			.get(async (req, res, next) => {
				try {
					const timeseries = await vectors.getTimeseries(req.params.vector_id, urlResolver);
					res.redirect(`/timeseries/${timeseries}`);
				} catch (err) {
					next(err);
				}
			});
	}
};

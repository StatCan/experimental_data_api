const vectors = require('./model');
const pagination = require('jsonapi-pagination');
const {RequestError} = require('express-api-server');
const paginationHelper = require('../../helpers/pagination');

async function validateVectorId(req, res, next) {
	if (!vectors.isValid(req.params.vector_id))
		return next(new RequestError(req, 400, 'Invalid indicator id'));

	if (!await vectors.exists(req.params.vector_id).catch(next))
		return next(new RequestError(req, 404, `Indicator '${req.params.vector_id}' not found`));

	next();
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
					let {length, list} = await vectors.list(start, count, urlResolver).catch(next);
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
					const vector = await vectors.get(req.params.vector_id, urlResolver).catch(next);

					let url = `/timeseries/${vector.attributes.timeseries}`;
					res.redirect(url);
				} catch (err) {
					next(err);
				}
			});
	}
};

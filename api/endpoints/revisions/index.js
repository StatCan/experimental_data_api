const {APIError} = require('express-api-server');

module.exports = {
	'/': (route, urlResolver) => {
		route
			.get(async (req, res, next) => {
				return next(new APIError(req, 501, 'Not implemented.....yet'));
			});
	}
};

const {URL} = require('url');
const {getServer} = require('express-api-server');
const routes = require('./routes');
const port = process.env.PORT || 8000;
// const sentryDSN = process.env.SENTRY_DSN;
const compression = require('./compression');

let urlRoot;

if (process.env.URL_ROOT) {
	try {
		new URL('', process.env.URL_ROOT);
		urlRoot = process.env.URL_ROOT;
	} catch (e) {
		throw new Error(`Invalid URL_ROOT (${process.env.URL_ROOT})`);
	}
}

const options = {
	port,
	urlRoot,
	compression,
	// sentryDSN
};

let api = getServer(routes, options);

if (!module.parent) {
	api.start();
	process.stdout.write(`API Ready on port ${port}\n\n`);
} else {
	module.exports = api;
}

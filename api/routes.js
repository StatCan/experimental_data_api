const endpoints = {};

for (const endpoint of [
	'indicators',
	'observations',
	'timeseries',
	'sources',
	'revisions',
	'notes',
	'legacy'
]) {
	endpoints[endpoint] = require(`./endpoints/${endpoint}`);
}

module.exports = endpoints;

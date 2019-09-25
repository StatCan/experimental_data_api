const compression = {};

for (let prop of ['chunkSize', 'level', 'memLevel', 'strategy', 'threshold']) {
	const env = `ZLIB_${prop.toUpperCase()}`;
	if (process.env[env]) {
		compression[prop] = process.env[env];
	}
}

module.exports = compression;

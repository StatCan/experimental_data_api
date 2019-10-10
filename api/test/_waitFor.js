const {promisify} = require('util');
const {Client} = require('pg').native;
const sleep = promisify((a, f) => setTimeout(f, a));
const loop = async () => {
	const client = new Client();
	const innerLoop = async () => {
		await sleep(1000);
		await loop();
	};
	await client.connect().catch(async () => await innerLoop());
	const res = await client.query('SELECT COUNT(*) FROM observations;').catch(() => {});
	client.end();
	if (!res || res.rows[0].count == 0) {
		await innerLoop();
	}
};

loop();

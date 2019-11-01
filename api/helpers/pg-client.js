const {Pool} = require('pg').native;

const pool = new Pool();

module.exports = {
	query: async (...queryList) => {
		const client = await pool.connect();
		const queries = queryList.map((query) => {
			let q;
			let params;
			if (typeof query === 'string') {
				q = query;
			} else {
				[q, ...params] = query;
			}
			return client.query(q, params);
		});
		const p = Promise.all(queries);
		p.then(client.release).catch((e) => e);
		return queries.length > 1 ? p : queries[0];
	}
};

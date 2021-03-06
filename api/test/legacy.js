/* eslint-env mocha */
/* eslint "node/no-unpublished-require": 0 */
const assert = require('assert');
const util = require('util');
const request = util.promisify(require('request'));
const api = require('../index');

describe('Vectors (Legacy)', () => {
	describe('Model', () => {
		const vectors = require('../endpoints/legacy/model');

		describe('`list` function', () => {
			it('should return an object containing list of vectors and total count', async () => {
				return new Promise(async (resolve, reject) => {
					const list = await vectors.list(0, 10).catch(reject);
					try {
						assert.strictEqual(typeof list, 'object');
						assert.strictEqual(list.length, 6);
						assert.strictEqual(list.list.length, 6);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should offset the list by the `start` argument', async () => {
				return new Promise(async (resolve, reject) => {
					const list = await vectors.list(1, 10).catch(reject);
					try {
						assert.strictEqual(list.list[0].id, 2);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should limit the list to the `count` argument', async () => {
				return new Promise(async (resolve, reject) => {
					const list = await vectors.list(0, 1).catch(reject);
					try {
						assert.strictEqual(list.list.length, 1);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});
		});

		describe('`isValid` function', () => {
			it('should return true for a valid vector id', () => {
				assert.strictEqual(vectors.isValid('12'), true);
			});

			it('should return false for an invalid vector id', () => {
				assert.strictEqual(vectors.isValid('1-2'), false);
			});

			it('should throw for an invalid vector id when `throwOnFalse is set to true`', () => {
				assert.throws(
					() => vectors.isValid('1-2', true),
					{
						message: 'Invalid vector id'
					}
				);
			});
		});

		describe('`exists` function', () => {
			it('should return `true` for existing vector', async () => {
				return new Promise(async (resolve, reject) => {
					const exists = await vectors.exists(4).catch(reject);
					try {
						assert.strictEqual(exists, true);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should return `false` for non-existing vector', async () => {
				return new Promise(async (resolve, reject) => {
					const exists = await vectors.exists(12345).catch(reject);
					try {
						assert.strictEqual(exists, false);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should throw for an invalid vector id`', async () => {
				return new Promise(async (resolve, reject) => {
					try {
						await vectors.exists('%invalid-id');
						reject('did not throw');
					} catch (err) {
						try {
							assert.strictEqual(err.message, 'Invalid vector id');
							resolve();
						} catch (err) {
							reject(err);
						}
					}
				});
			});

			it('should throw for an non-existing vector when `throwOnFalse is set to true`', () => {
				return new Promise(async (resolve, reject) => {
					try {
						await vectors.exists(999, true);
						reject('did not throw');
					} catch (err) {
						try {
							assert.strictEqual(err.message, 'Vector \'999\' not found');
							resolve();
						} catch (err) {
							reject(err);
						}
					}
				});
			});
		});

		describe('getTimeseries', () => {
			it('should return the timeseries id for a vector', async () => {
				return new Promise(async (resolve, reject) => {
					const timeseries = await vectors.getTimeseries(1).catch(reject);
					try {
						assert.strictEqual(timeseries, 'd3a06c6b-82a7-4efa-8f0f-6cb453deff2c');
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should throw for an invalid vector id`', async () => {
				return new Promise(async (resolve, reject) => {
					try {
						await vectors.getTimeseries('%invalid-id');
						reject('did not throw');
					} catch (err) {
						try {
							assert.strictEqual(err.message, 'Invalid vector id');
							resolve();
						} catch (err) {
							reject(err);
						}
					}
				});
			});

			it('should throw for non-existing vectors', async () => {
				return new Promise(async (resolve, reject) => {
					try {
						await vectors.getTimeseries(12345);
						reject(new Error('did not throw'));
					} catch (err) {
						try {
							assert.strictEqual(err.message, 'Vector \'12345\' not found');
							resolve();
						} catch (err) {
							reject(err);
						}
					}
				});
			});
		});
	});

	describe('API', () => {
		let server;

		before(() => {
			server = api.start();
		});

		after(() => {
			server.close();
		});

		describe('Output', () => {
			let vector;

			before(async () => {
				return new Promise(async (resolve, reject) => {
					const options = {
						uri: 'http://localhost:8000/legacy/vectors',
						json: true
					};
					try {
						const {body} = await request(options);
						vector = body.data[0];
						resolve();
					} catch (err) {
						reject(err);
					}
				});
			});

			it('should have a numerical id', () => {
				assert.strictEqual(typeof vector.id, 'number');
			});

			it('should have the type \'vector\'', () => {
				assert.strictEqual(vector.type, 'vector');
			});

			it('should have a link to itself', () => {
				assert.strictEqual(typeof vector.links, 'object');
				assert.strictEqual(vector.links.self, 'http://localhost:8000/timeseries/d3a06c6b-82a7-4efa-8f0f-6cb453deff2c');
			});

			it('should have the timeseries attribute', () => {
				assert.strictEqual(typeof vector.attributes, 'object');
				assert.strictEqual(vector.attributes.timeseries, 'd3a06c6b-82a7-4efa-8f0f-6cb453deff2c');
			});
		});

		describe('Routes', () => {
			describe('/legacy/vectors', () => {
				let req;
				let body;

				before(async () => {
					return new Promise(async (resolve, reject) => {
						const options = {
							uri: 'http://localhost:8000/legacy/vectors',
							json: true
						};
						try {
							({req, body} = await request(options));
							resolve();
						} catch (err) {
							reject(err);
						}
					});
				});

				it('should return an http 200 status code', () => {
					assert.strictEqual(req.res.statusCode, 200);
				});

				it('should return a list of vectors', () => {
					assert.strictEqual(body.data.length, 6);
					for (const vector of body.data) {
						assert.strictEqual(vector.type, 'vector');
					}
				});
			});

			describe('/legacy/vectors/:vector_id', () => {
				let req;

				before(async () => {
					return new Promise(async (resolve, reject) => {
						const options = {
							uri: 'http://localhost:8000/legacy/vectors/1',
							json: true
						};
						try {
							({req} = await request(options));
							resolve();
						} catch (err) {
							reject(err);
						}
					});
				});
				it('should redirect to the timeseries', () => {
					assert.strictEqual(req.path, '/timeseries/d3a06c6b-82a7-4efa-8f0f-6cb453deff2c');
				});
				it('should return an http 200 status code', () => {
					assert.strictEqual(req.res.statusCode, 200);
				});
			});
		});
	});
});

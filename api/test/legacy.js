/* eslint-env mocha */
/* eslint "node/no-unpublished-require": 0 */
const assert = require('assert');

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
			it('should return true for a valid indicator id', () => {
				assert.strictEqual(vectors.isValid('12'), true);
			});

			it('should return true for a valid indicator id', () => {
				assert.strictEqual(vectors.isValid('1-2'), false);
			});
		});

		describe('`exists` function', () => {
			it('should return `true` for existing indicator', async () => {
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

			it('should return `false` for non-existing indicator', async () => {
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

			it('should return undefined for non-existing vectors', async () => {
				return new Promise(async (resolve, reject) => {
					const timeseries = await vectors.getTimeseries(12345).catch(reject);
					try {
						assert.strictEqual(timeseries, undefined);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});
		});
	});

	describe('API', () => {
		describe('Output', () => {

		});

		describe('Routes', () => {

		});
	});
});
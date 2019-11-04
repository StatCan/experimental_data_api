/* eslint-env mocha */
/* eslint "node/no-unpublished-require": 0 */
const assert = require('assert');

describe('Observations', () => {
	describe('Model', () => {
		const observations = require('../endpoints/observations/model');

		describe('`list` function', () => {
			it('should return an object containing list of observations and total count', async () => {
				return new Promise(async (resolve, reject) => {
					const list = await observations.list(0, 10).catch(reject);
					try {
						assert.strictEqual(typeof list, 'object');
						assert.strictEqual(list.length, 13);
						assert.strictEqual(list.list.length, 10);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should return the same object as the `get` function', async () => {
				return new Promise(async (resolve, reject) => {
					const list = await observations.list(0, 10).catch(reject);
					const indicator = await observations.get(list.list[0].id).catch(reject);
					try {
						assert.strictEqual(JSON.stringify(list.list[0]), JSON.stringify(indicator));
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should offset the list by the `start` argument', async () => {
				return new Promise(async (resolve, reject) => {
					const start0 = await observations.list(0, 10).catch(reject);
					const start1 = await observations.list(1, 10).catch(reject);
					try {
						assert.strictEqual(start1.list[0].id, start0.list[1].id);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should limit the list to the `count` argument', async () => {
				return new Promise(async (resolve, reject) => {
					const list = await observations.list(0, 1).catch(reject);
					try {
						assert.strictEqual(list.list.length, 1);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			describe('Sorting', () => {
				it.skip('should have tests');
			});

			describe('Filtering', () => {
				describe('by Date', () => {
					it.skip('should have tests');
				});

				describe('by Timeseries', () => {
					it.skip('should have tests');
				});

				describe('by Indicator', () => {
					it.skip('should have tests');
				});

				describe('by Dimension', () => {
					it.skip('should have tests');
				});
			});
		});

		describe('`isValid` function', () => {
			it('should return true for a valid observation id', () => {
				assert.strictEqual(observations.isValid('235fd621-a670-4b62-b829-dc1da213e062'), true);
			});

			it('should return false for an invalid observation id', () => {
				assert.strictEqual(observations.isValid('%invalid-id'), false);
				assert.strictEqual(observations.isValid('235zz621-z670-4z62-z829-zz1dz213z062'), false);
			});

			it('should throw for an invalid observation id when `throwOnFalse is set to true`', () => {
				assert.throws(
					() => observations.isValid('235zz621-z670-4z62-z829-zz1dz213z062', true),
					{
						message: 'Invalid observation id'
					}
				);
			});
		});

		describe('`exists` function', () => {
			it('should return `true` for existing observation', async () => {
				return new Promise(async (resolve, reject) => {
					const exists = await observations.exists('41f7ef3e-2dd1-4864-ac77-5daa4c13f04f').catch(reject);
					try {
						assert.strictEqual(exists, true);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should return `false` for non-existing observation', async () => {
				return new Promise(async (resolve, reject) => {
					const exists = await observations.exists('8a9be92b-8b1b-4783-b9ff-4bec20e067a8').catch(reject);
					try {
						assert.strictEqual(exists, false);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should throw for an invalid observation id`', async () => {
				return new Promise(async (resolve, reject) => {
					try {
						await observations.exists('%invalid-id');
						reject('did not throw');
					} catch (err) {
						try {
							assert.strictEqual(err.message, 'Invalid observation id');
							resolve();
						} catch (err) {
							reject(err);
						}
					}
				});
			});

			it('should throw for an non-existing observation when `throwOnFalse is set to true`', () => {
				return new Promise(async (resolve, reject) => {
					try {
						await observations.exists('8a9be92b-8b1b-4783-b9ff-4bec20e067a8', true);
						reject('did not throw');
					} catch (err) {
						try {
							assert.strictEqual(err.message, 'Observation \'8a9be92b-8b1b-4783-b9ff-4bec20e067a8\' not found');
							resolve();
						} catch (err) {
							reject(err);
						}
					}
				});
			});
		});

		describe('`get` function', () => {
			it('should return an observation object', async () => {
				return new Promise(async (resolve, reject) => {
					const indicator = await observations.get('41f7ef3e-2dd1-4864-ac77-5daa4c13f04f').catch(reject);
					try {
						assert.strictEqual(indicator.type, 'observation');
						assert.strictEqual(indicator.id, '41f7ef3e-2dd1-4864-ac77-5daa4c13f04f');
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should return `undefined` for non-existing observation', async () => {
				return new Promise(async (resolve, reject) => {
					const indicator = await observations.get('8a9be92b-8b1b-4783-b9ff-4bec20e067a8').catch(reject);
					try {
						assert.strictEqual(indicator, undefined);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should throw for an invalid observation id`', async () => {
				return new Promise(async (resolve, reject) => {
					try {
						await observations.get('%invalid-id');
						reject('did not throw');
					} catch (err) {
						try {
							assert.strictEqual(err.message, 'Invalid observation id');
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
		describe('Output', () => {

		});

		describe('Routes', () => {

		});
	});
});

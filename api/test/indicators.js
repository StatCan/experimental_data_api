/* eslint-env mocha */
/* eslint "node/no-unpublished-require": 0 */
const assert = require('assert');

describe('Indicators', () => {
	describe('Model', () => {
		const indicators = require('../endpoints/indicators/model');

		describe('`list` function', () => {
			it('should return an object containing list of indicators and total count', async () => {
				return new Promise(async (resolve, reject) => {
					const list = await indicators.list(0, 10).catch(reject);
					try {
						assert.strictEqual(typeof list, 'object');
						assert.strictEqual(list.length, 2);
						assert.strictEqual(list.list.length, 2);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should return the same object as the `get` function', async () => {
				return new Promise(async (resolve, reject) => {
					const list = await indicators.list(0, 10).catch(reject);
					const indicator = await indicators.get(list.list[0].id).catch(reject);
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
					const start0 = await indicators.list(0, 10).catch(reject);
					const start1 = await indicators.list(1, 10).catch(reject);
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
					const list = await indicators.list(0, 1).catch(reject);
					try {
						assert.strictEqual(list.list.length, 1);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			describe('Sorting', () => {
				it.skip('should sort by date modified in descending order by default');
				it.skip('should sort by date modified in descending order when sorting is set to `dateModified` and order is undefined');
				it.skip('should sort by date modified in descending order when sorting is set to `dateModified` and order is set to `descending`');
				it.skip('should sort by date modified in ascending order when sorting is set to `dateModified` and order is set to `ascending`');
				it.skip('should sort by name in ascending alphabetical order when sorting is set to `name` and order is undefined');
				it.skip('should sort by name in ascending alphabetical order when sorting is set to `name` and order is set to `ascending`');
				it.skip('should sort by name in descending alphabetical order when sorting is set to `name` and order is set to `descending`');
			});

			describe('Filtering', () => {
				it.skip('should filter indicators by subject');
			});
		});

		describe('`isValid` function', () => {
			it('should return true for a valid indicator id', () => {
				assert.strictEqual(indicators.isValid('test_indicator-id1'), true);
			});

			it('should return false for an invalid indicator id', () => {
				assert.strictEqual(indicators.isValid('%invalid-id'), false);
			});

			it('should throw for an invalid indicator id when `throwOnFalse is set to true`', () => {
				assert.throws(
					() => indicators.isValid('%invalid-id', true),
					{
						message: 'Invalid indicator id'
					}
				);
			});
		});

		describe('`exists` function', () => {
			it('should return `true` for existing indicator', async () => {
				return new Promise(async (resolve, reject) => {
					const exists = await indicators.exists('indicator2').catch(reject);
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
					const exists = await indicators.exists('indicator0').catch(reject);
					try {
						assert.strictEqual(exists, false);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should throw for an invalid indicator id`', async () => {
				return new Promise(async (resolve, reject) => {
					try {
						await indicators.exists('%invalid-id');
						reject('did not throw');
					} catch (err) {
						try {
							assert.strictEqual(err.message, 'Invalid indicator id');
							resolve();
						} catch (err) {
							reject(err);
						}
					}
				});
			});

			it('should throw for an non-existing indicator when `throwOnFalse is set to true`', () => {
				return new Promise(async (resolve, reject) => {
					try {
						await indicators.exists('indicator0', true);
						reject('did not throw');
					} catch (err) {
						try {
							assert.strictEqual(err.message, 'Indicator \'indicator0\' not found');
							resolve();
						} catch (err) {
							reject(err);
						}
					}
				});
			});
		});

		describe('`get` function', () => {
			it('should return an indicator object', async () => {
				return new Promise(async (resolve, reject) => {
					const indicator = await indicators.get('indicator2').catch(reject);
					try {
						assert.strictEqual(indicator.type, 'indicator');
						assert.strictEqual(indicator.id, 'indicator2');
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should return `undefined` for non-existing indicator', async () => {
				return new Promise(async (resolve, reject) => {
					const indicator = await indicators.get('indicator0').catch(reject);
					try {
						assert.strictEqual(indicator, undefined);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should throw for an invalid indicator id`', async () => {
				return new Promise(async (resolve, reject) => {
					try {
						await indicators.get('%invalid-id');
						reject('did not throw');
					} catch (err) {
						try {
							assert.strictEqual(err.message, 'Invalid indicator id');
							resolve();
						} catch (err) {
							reject(err);
						}
					}
				});
			});
		});

		describe('`listObservations` function', () => {
			const observations = require('../endpoints/observations/model');

			it('should return an object containing list of observations for the indicators and total count', async () => {
				return new Promise(async (resolve, reject) => {
					const indicator = 'indicator1';
					const observationsList = await indicators.listObservations(indicator, 0, 10).catch(reject);
					try {
						assert.strictEqual(observationsList.length, 5);
						for (const {type, relationships: {indicator: {data: {id: observationIndicator}}}} of observationsList.list) {
							assert.strictEqual(type, 'observation');
							assert.strictEqual(indicator, observationIndicator);
						}
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should return the same list as the observations model `list` function', async () => {
				return new Promise(async (resolve, reject) => {
					const indicator = 'indicator1';
					const indicatorObservations = await indicators.listObservations(indicator, 0, 10).catch(reject);
					const indicatorObservations2 = await observations.list(0, 10, undefined, {indicator}).catch(reject);

					try {
						assert.strictEqual(JSON.stringify(indicatorObservations), JSON.stringify(indicatorObservations2));
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should not error for non-existing indicator', async () => {
				return new Promise(async (resolve, reject) => {
					const observationsList = await indicators.listObservations('indicator0', 0, 10).catch(reject);
					try {
						assert.strictEqual(JSON.stringify(observationsList), '{"length":0,"list":[]}');
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should throw for an invalid indicator id`', async () => {
				return new Promise(async (resolve, reject) => {
					try {
						await indicators.listObservations('%invalid-id');
						reject('did not throw');
					} catch (err) {
						try {
							assert.strictEqual(err.message, 'Invalid indicator id');
							resolve();
						} catch (err) {
							reject(err);
						}
					}
				});
			});

			it('should offset the list by the `start` argument', async () => {
				return new Promise(async (resolve, reject) => {
					const observations1 = await indicators.listObservations('indicator1', 1, 10).catch(reject);
					const observations2 = await indicators.listObservations('indicator1', 0, 10).catch(reject);
					try {
						assert.strictEqual(observations1.list[0].id, observations2.list[1].id);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should limit the list to the `count` argument', async () => {
				return new Promise(async (resolve, reject) => {
					const observationsList = await indicators.listObservations('indicator1', 0, 1).catch(reject);
					try {
						assert.strictEqual(observationsList.list.length, 1);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			describe('Sorting', () => {
				it.skip('should sort by date modified in descending order by default');
				it.skip('should sort by date modified in descending order when sorting is set to `dateModified` and order is undefined');
				it.skip('should sort by date modified in descending order when sorting is set to `dateModified` and order is set to `descending`');
				it.skip('should sort by date modified in ascending order when sorting is set to `dateModified` and order is set to `ascending`');
				it.skip('should sort by reference period in descending order when sorting is set to `referencePeriod` and order is undefined');
				it.skip('should sort by reference period in descending order when sorting is set to `referencePeriod` and order is set to `descending`');
				it.skip('should sort by reference period in ascending order when sorting is set to `referencePeriod` and order is set to `ascending`');
			});

			describe('Filtering', () => {
				it('should send filtering options to the observation `list` function', async () => {
					return new Promise(async (resolve, reject) => {
						const indicator = 'indicator1';
						const filters = {dimensions: {sex: ['female']}};
						const noFilter = await indicators.listObservations(indicator, 0, 10).catch(reject);
						const indicatorObservations = await indicators.listObservations(indicator, 0, 10, undefined, filters).catch(reject);
						const observationsList = await observations.list(0, 10, undefined, {indicator: indicator, ...filters}).catch(reject);
						try {
							assert.notStrictEqual(JSON.stringify(noFilter), JSON.stringify(indicatorObservations));
							assert.strictEqual(JSON.stringify(indicatorObservations), JSON.stringify(observationsList));
							resolve();
						} catch (e) {
							reject(e);
						}
					});
				});
			});
		});

		describe('`listTimeseries` function', () => {
			const timeseries = require('../endpoints/timeseries/model');

			it('should return an object containing list of observations for the indicators and total count', async () => {
				return new Promise(async (resolve, reject) => {
					const indicator = 'indicator1';
					const timeseriesList = await indicators.listTimeseries(indicator, 0, 10).catch(reject);
					try {
						assert.strictEqual(timeseriesList.length, 2);
						for (const {type, relationships: {indicator: {data: {id: observationIndicator}}}} of timeseriesList.list) {
							assert.strictEqual(type, 'timeseries');
							assert.strictEqual(indicator, observationIndicator);
						}
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should return the same list as the observations model `list` function', async () => {
				return new Promise(async (resolve, reject) => {
					const indicator = 'indicator1';
					const indicatorTimeseries = await indicators.listTimeseries(indicator, 0, 10).catch(reject);
					const indicatorTimeseries2 = await timeseries.list(0, 10, undefined, {indicator}).catch(reject);

					try {
						assert.strictEqual(JSON.stringify(indicatorTimeseries), JSON.stringify(indicatorTimeseries2));
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should not error for non-existing indicator', async () => {
				return new Promise(async (resolve, reject) => {
					const timeseriesList = await indicators.listTimeseries('indicator0', 0, 10).catch(reject);
					try {
						assert.strictEqual(JSON.stringify(timeseriesList), '{"length":0,"list":[]}');
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should throw for an invalid indicator id`', async () => {
				return new Promise(async (resolve, reject) => {
					try {
						await indicators.listTimeseries('%invalid-id');
						reject('did not throw');
					} catch (err) {
						try {
							assert.strictEqual(err.message, 'Invalid indicator id');
							resolve();
						} catch (err) {
							reject(err);
						}
					}
				});
			});

			it('should offset the list by the `start` argument', async () => {
				return new Promise(async (resolve, reject) => {
					const indicator = 'indicator1';
					const timeseries1 = await indicators.listTimeseries(indicator, 1, 10).catch(reject);
					const timeseries2 = await indicators.listTimeseries(indicator, 0, 10).catch(reject);
					try {
						assert.strictEqual(timeseries1.list[0].id, timeseries2.list[1].id);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should limit the list to the `count` argument', async () => {
				return new Promise(async (resolve, reject) => {
					const timeseriesList = await indicators.listTimeseries('indicator1', 0, 1).catch(reject);
					try {
						assert.strictEqual(timeseriesList.list.length, 1);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			describe('Filtering', () => {
				it('should send filtering options to the timeseries `list` function', async () => {
					return new Promise(async (resolve, reject) => {
						const indicator = 'indicator2';
						const filters = {dimensions: {sex: ['female']}};
						const noFilter = await indicators.listTimeseries(indicator, 0, 10).catch(reject);
						const indicatorTimeseries = await indicators.listTimeseries(indicator, 0, 10, undefined, filters).catch(reject);
						const timeseriesList = await timeseries.list(0, 10, undefined, {indicator: indicator, ...filters}).catch(reject);
						try {
							assert.notStrictEqual(JSON.stringify(noFilter), JSON.stringify(indicatorTimeseries));
							assert.strictEqual(JSON.stringify(indicatorTimeseries), JSON.stringify(timeseriesList));
							resolve();
						} catch (e) {
							reject(e);
						}
					});
				});
			});
		});

		describe('`getJSONStat` function', () => {
			it.skip('should return a JSONStat object for the indicator', async () => {
				// return new Promise(async (resolve, reject) => {
				// 	const jsonstat = await indicators.getJSONStat('indicator1').catch(reject);
				// 	try {
				// 		assert.strictEqual();
				// 		resolve();
				// 	} catch (e) {
				// 		reject(e);
				// 	}
				// });
			});

			it('should throw for an invalid indicator id`', async () => {
				return new Promise(async (resolve, reject) => {
					try {
						await indicators.listTimeseries('%invalid-id');
						reject('did not throw');
					} catch (err) {
						try {
							assert.strictEqual(err.message, 'Invalid indicator id');
							resolve();
						} catch (err) {
							reject(err);
						}
					}
				});
			});
		});

		describe('`getSDMX` function', () => {
			it.skip('should return an SDMX string for the indicator', async () => {
				// return new Promise(async (resolve, reject) => {
				// 	const sdmx = await indicators.getSDMX('indicator1').catch(reject);
				// 	try {
				// 		assert.strictEqual();
				// 		resolve();
				// 	} catch (e) {
				// 		reject(e);
				// 	}
				// });
			});

			it('should throw for an invalid indicator id`', async () => {
				return new Promise(async (resolve, reject) => {
					try {
						await indicators.listTimeseries('%invalid-id');
						reject('did not throw');
					} catch (err) {
						try {
							assert.strictEqual(err.message, 'Invalid indicator id');
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
			describe('/indicators', () => {
				it.skip('should have tests');
			});

			describe('/indicators/:indicator_id', () => {
				it.skip('should have tests');
			});

			describe('/indicators/:indicator_id/observations', () => {
				it.skip('should have tests');
			});

			describe('/indicators/:indicator_id/timeseries', () => {
				it.skip('should have tests');
			});

			describe('/indicators/:indicator_id/json-stat', () => {
				it.skip('should have tests');
			});

			describe('/indicators/:indicator_id/sdmx', () => {
				it.skip('should have tests');
			});
		});
	});
});

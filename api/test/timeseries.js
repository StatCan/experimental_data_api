/* eslint-env mocha */
/* eslint "node/no-unpublished-require": 0 */
const assert = require('assert');
const util = require('util');
const request = util.promisify(require('request'));
const api = require('../index');

describe('Timeseries', () => {
	describe('Model', () => {
		const timeseries = require('../endpoints/timeseries/model');

		describe('`list` function', () => {
			it('should return an object containing list of timeseries and total count', async () => {
				return new Promise(async (resolve, reject) => {
					const list = await timeseries.list(0, 10).catch(reject);
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

			it('should return the same object as the `get` function', async () => {
				return new Promise(async (resolve, reject) => {
					const list = await timeseries.list(0, 10).catch(reject);
					const timeseriesObj = await timeseries.get(list.list[0].id).catch(reject);
					try {
						assert.strictEqual(JSON.stringify(list.list[0]), JSON.stringify(timeseriesObj));
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should offset the list by the `start` argument', async () => {
				return new Promise(async (resolve, reject) => {
					const start0 = await timeseries.list(0, 10).catch(reject);
					const start1 = await timeseries.list(1, 10).catch(reject);
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
					const list = await timeseries.list(0, 1).catch(reject);
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
				describe('by Indicator', () => {
					it('should filter observations when an existing indicator is specified', async () => {
						return new Promise(async (resolve, reject) => {
							const indicator = 'indicator1';
							const list = await timeseries.list(0, 10, undefined, {
								indicator
							}).catch(reject);
							try {
								assert.strictEqual(list.list.length, 2);
								assert.strictEqual(list.length, 2);
								for (const obs of list.list) {
									assert.strictEqual(obs.relationships.indicator.data.id, indicator);
								}
								resolve();
							} catch (e) {
								reject(e);
							}
						});
					});

					it('should filter observations when an non-existing indicator is specified', async () => {
						return new Promise(async (resolve, reject) => {
							const list = await timeseries.list(0, 10, undefined, {
								indicator: 'indicator0'
							}).catch(reject);
							try {
								assert.strictEqual(list.list.length, 0);
								assert.strictEqual(list.length, 0);
								assert.strictEqual(JSON.stringify(list.list), '[]');
								resolve();
							} catch (e) {
								reject(e);
							}
						});
					});

					it('should throw when an invalid indicator id is specified', async () => {
						return new Promise(async (resolve, reject) => {
							try {
								await timeseries.list(0, 10, undefined, {
									indicator: '%invalid-id'
								});
								reject('did not throw');
							} catch (e) {
								try {
									assert.strictEqual(e.message, 'Invalid indicator id');
									resolve();
								} catch (e) {
									reject(e);
								}
							}
						});
					});
				});

				describe('by Dimension', () => {
					it('should filter observations when one dimension filter with one value is specified', async () => {
						return new Promise(async (resolve, reject) => {
							const sex = 'female';
							const list = await timeseries.list(0, 10, undefined, {
								dimensions: {
									sex
								}
							}).catch(reject);
							try {
								assert.strictEqual(list.list.length, 2);
								assert.strictEqual(list.length, 2);
								for (const obs of list.list) {
									assert.strictEqual(obs.attributes.dimensions.sex, sex);
								}
								resolve();
							} catch (e) {
								reject(e);
							}
						});
					});

					it('should filter observations when one dimension filter with multiple values are specified', async () => {
						return new Promise(async (resolve, reject) => {
							const sex = ['male', 'female'];
							const list = await timeseries.list(0, 10, undefined, {
								dimensions: {
									sex
								}
							}).catch(reject);
							try {
								assert.strictEqual(list.list.length, 4);
								assert.strictEqual(list.length, 4);
								for (const obs of list.list) {
									const s = obs.attributes.dimensions.sex;
									assert.ok(sex.indexOf(s) !== -1, `sex is '${s}' but should be one of ['${sex.join('\', \'')}']`);
								}
								resolve();
							} catch (e) {
								reject(e);
							}
						});
					});

					it('should filter observations when multiple dimension filters with one value each is specified', async () => {
						return new Promise(async (resolve, reject) => {
							const dimensions = {
								sex: 'female',
								geographicArea: '24'
							};
							const list = await timeseries.list(0, 10, undefined, {
								dimensions: {...dimensions}
							}).catch(reject);
							try {
								assert.strictEqual(list.list.length, 1);
								assert.strictEqual(list.length, 1);
								for (const obs of list.list) {
									assert.strictEqual(JSON.stringify(obs.attributes.dimensions), JSON.stringify(dimensions));
								}
								resolve();
							} catch (e) {
								reject(e);
							}
						});
					});

					it('should filter observations when multiple dimension filters with multiple values each are specified', async () => {
						return new Promise(async (resolve, reject) => {
							const dimensions = {
								sex: ['male', 'female'],
								geographicArea: ['24', '35']
							};
							const list = await timeseries.list(0, 10, undefined, {
								dimensions: {...dimensions}
							}).catch(reject);
							try {
								assert.strictEqual(list.list.length, 4);
								assert.strictEqual(list.length, 4);
								for (const obs of list.list) {
									const d = obs.attributes.dimensions;
									assert.ok(dimensions.sex.indexOf(d.sex) !== -1, `sex is '${d.sex}' but should be one of ['${dimensions.sex.join('\', \'')}']`);
									assert.ok(dimensions.geographicArea.indexOf(d.geographicArea) !== -1, `geographicArea is '${d.geographicArea}' but should be one of ['${dimensions.geographicArea.join('\', \'')}']`);
								}
								resolve();
							} catch (e) {
								reject(e);
							}
						});
					});

					it('should throw when an invalid dimension name is specified', async () => {
						return new Promise(async (resolve, reject) => {
							try {
								await timeseries.list(0, 10, undefined, {
									dimensions: {
										'%invalid-id': 'test'
									}
								});
								reject('did not throw');
							} catch (e) {
								try {
									assert.strictEqual(e.message, 'Invalid dimensions name %invalid-id');
									resolve();
								} catch (e) {
									reject(e);
								}
							}
						});
					});

					it('should throw when an invalid dimension value is specified', async () => {
						return new Promise(async (resolve, reject) => {
							try {
								await timeseries.list(0, 10, undefined, {
									dimensions: {
										sex: '%invalid-value'
									}
								});
								reject('did not throw');
							} catch (e) {
								try {
									assert.strictEqual(e.message, 'Invalid dimension value: \'%invalid-value\'');
									resolve();
								} catch (e) {
									reject(e);
								}
							}
						});
					});
				});
			});
		});

		describe('`isValid` function', () => {
			it('should return true for a valid timeseries id', () => {
				assert.strictEqual(timeseries.isValid('235fd621-a670-4b62-b829-dc1da213e062'), true);
			});

			it('should return false for an invalid timeseries id', () => {
				assert.strictEqual(timeseries.isValid('%invalid-id'), false);
				assert.strictEqual(timeseries.isValid('235zz621-z670-4z62-z829-zz1dz213z062'), false);
			});

			it('should throw for an invalid timeseries id when `throwOnFalse is set to true`', () => {
				assert.throws(
					() => timeseries.isValid('1-2', true),
					{
						message: 'Invalid timeseries id'
					}
				);
			});
		});

		describe('`exists` function', () => {
			it('should return `true` for existing timeseries', async () => {
				return new Promise(async (resolve, reject) => {
					const exists = await timeseries.exists('e052c4b3-ae8b-43ca-a6f7-ff75fcfc49c5').catch(reject);
					try {
						assert.strictEqual(exists, true);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should return `false` for non-existing timeseries', async () => {
				return new Promise(async (resolve, reject) => {
					const exists = await timeseries.exists('f052c4b3-ae8b-43ca-a6f7-ff75fcfc49c5').catch(reject);
					try {
						assert.strictEqual(exists, false);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should throw for an invalid timeseries id`', async () => {
				return new Promise(async (resolve, reject) => {
					try {
						await timeseries.exists('%invalid-id');
						reject('did not throw');
					} catch (err) {
						try {
							assert.strictEqual(err.message, 'Invalid timeseries id');
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
						await timeseries.exists('f052c4b3-ae8b-43ca-a6f7-ff75fcfc49c5', true);
						reject('did not throw');
					} catch (err) {
						try {
							assert.strictEqual(err.message, 'Timeseries \'f052c4b3-ae8b-43ca-a6f7-ff75fcfc49c5\' not found');
							resolve();
						} catch (err) {
							reject(err);
						}
					}
				});
			});
		});

		describe('`get` function', () => {
			it('should return an timeseries object', async () => {
				return new Promise(async (resolve, reject) => {
					const timeseriesObj = await timeseries.get('e052c4b3-ae8b-43ca-a6f7-ff75fcfc49c5').catch(reject);
					try {
						assert.strictEqual(timeseriesObj.type, 'timeseries');
						assert.strictEqual(timeseriesObj.id, 'e052c4b3-ae8b-43ca-a6f7-ff75fcfc49c5');
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should return `undefined` for non-existing timeseries', async () => {
				return new Promise(async (resolve, reject) => {
					const timeseriesObj = await timeseries.get('f052c4b3-ae8b-43ca-a6f7-ff75fcfc49c5').catch(reject);
					try {
						assert.strictEqual(timeseriesObj, undefined);
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should throw for an invalid timeseries id`', async () => {
				return new Promise(async (resolve, reject) => {
					try {
						await timeseries.get('%invalid-id');
						reject('did not throw');
					} catch (err) {
						try {
							assert.strictEqual(err.message, 'Invalid timeseries id');
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

			it('should return an object containing list of observations for the timeseries and total count', async () => {
				return new Promise(async (resolve, reject) => {
					const timeseriesId = 'e052c4b3-ae8b-43ca-a6f7-ff75fcfc49c5';
					const timeseriesList = await timeseries.listObservations(timeseriesId, 0, 10).catch(reject);
					try {
						assert.strictEqual(timeseriesList.length, 2);
						for (const {type, relationships: {timeseries: {data: {id: observationTimeseries}}}} of timeseriesList.list) {
							assert.strictEqual(type, 'observation');
							assert.strictEqual(timeseriesId, observationTimeseries);
						}
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should return the same list as the observations model `list` function', async () => {
				return new Promise(async (resolve, reject) => {
					const timeseriesId = 'e052c4b3-ae8b-43ca-a6f7-ff75fcfc49c5';
					const timeseriesObservations = await timeseries.listObservations(timeseriesId, 0, 10).catch(reject);
					const timeseriesObservations2 = await observations.list(0, 10, undefined, {timeseries: timeseriesId}).catch(reject);

					try {
						assert.strictEqual(JSON.stringify(timeseriesObservations), JSON.stringify(timeseriesObservations2));
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should not error for non-existing timeseries', async () => {
				return new Promise(async (resolve, reject) => {
					const timeseriesList = await timeseries.listObservations('f052c4b3-ae8b-43ca-a6f7-ff75fcfc49c5', 0, 10).catch(reject);
					try {
						assert.strictEqual(JSON.stringify(timeseriesList), '{"length":0,"list":[]}');
						resolve();
					} catch (e) {
						reject(e);
					}
				});
			});

			it('should throw for an invalid timeseries id`', async () => {
				return new Promise(async (resolve, reject) => {
					try {
						await timeseries.listObservations('%invalid-id');
						reject('did not throw');
					} catch (err) {
						try {
							assert.strictEqual(err.message, 'Invalid timeseries id');
							resolve();
						} catch (err) {
							reject(err);
						}
					}
				});
			});

			it('should offset the list by the `start` argument', async () => {
				return new Promise(async (resolve, reject) => {
					const timeseries1 = await timeseries.listObservations('e052c4b3-ae8b-43ca-a6f7-ff75fcfc49c5', 1, 10).catch(reject);
					const timeseries2 = await timeseries.listObservations('e052c4b3-ae8b-43ca-a6f7-ff75fcfc49c5', 0, 10).catch(reject);
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
					const observationsList = await timeseries.listObservations('e052c4b3-ae8b-43ca-a6f7-ff75fcfc49c5', 0, 1).catch(reject);
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
						const timeseriesId = 'e052c4b3-ae8b-43ca-a6f7-ff75fcfc49c5';
						const filters = {dimensions: {sex: ['female']}};
						const noFilter = await timeseries.listObservations(timeseriesId, 0, 10).catch(reject);
						const timeseriesObservations = await timeseries.listObservations(timeseriesId, 0, 10, undefined, filters).catch(reject);
						const observationsList = await observations.list(0, 10, undefined, {timeseries: timeseriesId, ...filters}).catch(reject);
						try {
							assert.notStrictEqual(JSON.stringify(noFilter), JSON.stringify(timeseriesObservations));
							assert.strictEqual(JSON.stringify(timeseriesObservations), JSON.stringify(observationsList));
							resolve();
						} catch (e) {
							reject(e);
						}
					});
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
			const timeseries = 'd3a06c6b-82a7-4efa-8f0f-6cb453deff2c';
			const indicator = 'indicator1';
			const uri = `http://localhost:8000/timeseries/${timeseries}`;
			let body;
			before(async () => {
				return new Promise(async (resolve, reject) => {
					const options = {
						uri,
						json: true
					};
					try {
						({body} = await request(options));
						resolve();
					} catch (err) {
						reject(err);
					}
				});
			});
			it('should have an id', () => {
				assert.strictEqual(body.data.id, timeseries);
			});

			it('should have the `observation` type', () => {
				assert.strictEqual(body.data.type, 'timeseries');
			});

			it('should have a link to itself', () => {
				assert.strictEqual(typeof body.data.links, 'object');
				assert.strictEqual(body.data.links.self, uri);
			});

			it('should have an object for the `dimensions` attribute', () => {
				const dimensions = {
					geographicArea: '24'
				};
				assert.strictEqual(typeof body.data.attributes.dimensions, 'object');
				assert.strictEqual(JSON.stringify(body.data.attributes.dimensions), JSON.stringify(dimensions));
			});

			it('should have a relationship link to the timeseries\' observations', () => {
				assert.strictEqual(body.data.relationships.observations.links.self, `${uri}/observations`);
			});

			it('should have a relationship link to the timeseries\' indicator', () => {
				assert.strictEqual(body.data.relationships.indicator.links.self, `http://localhost:8000/indicators/${indicator}`);
			});

			it('should have a relationship reference to the timeseries\' indicator', () => {
				assert.strictEqual(body.data.relationships.indicator.data.id, indicator);
				assert.strictEqual(body.data.relationships.indicator.data.type, 'indicator');
			});
		});

		describe('Routes', () => {
			describe('/timeseries', () => {
				it.skip('should have tests');
			});

			describe('/timeseries/:timeseries_id', () => {
				it.skip('should have tests');
			});

			describe('/timeseries/:timeseries_id/observations', () => {
				it.skip('should have tests');
			});
		});
	});
});

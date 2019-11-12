/* eslint-env mocha */
/* eslint "node/no-unpublished-require": 0 */
const assert = require('assert');
const util = require('util');
const request = util.promisify(require('request'));
const api = require('../index');

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
					describe('ISO 8601 date range string', () => {
						it('should filter observations when a start and end are specified', async () => {
							return new Promise(async (resolve, reject) => {
								const list = await observations.list(0, 10, undefined, {
									period: '2019-01-15/2019-02-15'
								}).catch(reject);
								try {
									assert.strictEqual(list.list.length, 6);
									assert.strictEqual(list.length, 6);
									for (const obs of list.list) {
										assert.strictEqual(obs.attributes.period, '2019-02-01');
									}
									resolve();
								} catch (e) {
									reject(e);
								}
							});
						});

						it('should filter observations when a start-only string is specified', async () => {
							return new Promise(async (resolve, reject) => {
								const list = await observations.list(0, 10, undefined, {
									period: '2019-02-15/'
								}).catch(reject);
								try {
									assert.strictEqual(list.list.length, 1);
									assert.strictEqual(list.length, 1);
									assert.strictEqual(list.list[0].attributes.period, '2019-03-01');
									resolve();
								} catch (e) {
									reject(e);
								}
							});
						});

						it('should filter observations when a end-only string is specified', async () => {
							return new Promise(async (resolve, reject) => {
								const list = await observations.list(0, 10, undefined, {
									period: '/2019-01-15'
								}).catch(reject);
								try {
									assert.strictEqual(list.list.length, 6);
									assert.strictEqual(list.length, 6);
									for (const obs of list.list) {
										assert.strictEqual(obs.attributes.period, '2019-01-01');
									}
									resolve();
								} catch (e) {
									reject(e);
								}
							});
						});

						it('should throw when an invalid date range string is specified', async () => {
							return new Promise(async (resolve, reject) => {
								try {
									await observations.list(0, 10, undefined, {
										period: '01/01/2019'
									});
									reject('did not throw');
								} catch (e) {
									try {
										assert.strictEqual(e.message, 'Parameter period is invalid. Period has to be formatted either as \'period=YYYY-MM-DD/YYYY-MM-DD\' or \'period[start]=YYYY-MM-DD&period[end]=YYYY-MM-DD\'');
										resolve();
									} catch (e) {
										reject(e);
									}
								}
							});
						});
					});

					describe('Start and end parameters', () => {
						it('should filter observations when a start and end are specified', async () => {
							return new Promise(async (resolve, reject) => {
								const list = await observations.list(0, 10, undefined, {
									period: {
										start: '2019-01-15',
										end: '2019-02-15'
									}
								}).catch(reject);
								try {
									assert.strictEqual(list.list.length, 6);
									assert.strictEqual(list.length, 6);
									for (const obs of list.list) {
										assert.strictEqual(obs.attributes.period, '2019-02-01');
									}
									resolve();
								} catch (e) {
									reject(e);
								}
							});
						});

						it('should filter observations when a start-only string is specified', async () => {
							return new Promise(async (resolve, reject) => {
								const list = await observations.list(0, 10, undefined, {
									period: {
										start: '2019-02-15'
									}
								}).catch(reject);
								try {
									assert.strictEqual(list.list.length, 1);
									assert.strictEqual(list.length, 1);
									assert.strictEqual(list.list[0].attributes.period, '2019-03-01');
									resolve();
								} catch (e) {
									reject(e);
								}
							});
						});

						it('should filter observations when a end-only string is specified', async () => {
							return new Promise(async (resolve, reject) => {
								const list = await observations.list(0, 10, undefined, {
									period: {
										end: '2019-01-15'
									}
								}).catch(reject);
								try {
									assert.strictEqual(list.list.length, 6);
									assert.strictEqual(list.length, 6);
									for (const obs of list.list) {
										assert.strictEqual(obs.attributes.period, '2019-01-01');
									}
									resolve();
								} catch (e) {
									reject(e);
								}
							});
						});

						it('should throw when an invalid start date is specified', async () => {
							return new Promise(async (resolve, reject) => {
								try {
									await observations.list(0, 10, undefined, {
										period: {
											start: '01/35/2019'
										}
									});
									reject('did not throw');
								} catch (e) {
									try {
										assert.strictEqual(e.message, 'Parameter period[start] is invalid. Expecting date in ISO 8601 format (YYYY-MM-DD)');
										resolve();
									} catch (e) {
										reject(e);
									}
								}
							});
						});

						it('should throw when an invalid end date is specified', async () => {
							return new Promise(async (resolve, reject) => {
								try {
									await observations.list(0, 10, undefined, {
										period: {
											end: '01/35/2019'
										}
									});
									reject('did not throw');
								} catch (e) {
									try {
										assert.strictEqual(e.message, 'Parameter period[end] is invalid. Expecting date in ISO 8601 format (YYYY-MM-DD)');
										resolve();
									} catch (e) {
										reject(e);
									}
								}
							});
						});
					});
				});

				describe('by Indicator', () => {
					it('should filter observations when an existing indicator is specified', async () => {
						return new Promise(async (resolve, reject) => {
							const indicator = 'indicator1';
							const list = await observations.list(0, 10, undefined, {
								indicator
							}).catch(reject);
							try {
								assert.strictEqual(list.list.length, 5);
								assert.strictEqual(list.length, 5);
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
							const list = await observations.list(0, 10, undefined, {
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
								await observations.list(0, 10, undefined, {
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

				describe('by Timeseries', () => {
					it('should filter observations when an existing timeseries is specified', async () => {
						return new Promise(async (resolve, reject) => {
							const timeseries = 'e052c4b3-ae8b-43ca-a6f7-ff75fcfc49c5';
							const list = await observations.list(0, 10, undefined, {
								timeseries
							}).catch(reject);
							try {
								assert.strictEqual(list.list.length, 2);
								assert.strictEqual(list.length, 2);
								for (const obs of list.list) {
									assert.strictEqual(obs.relationships.timeseries.data.id, timeseries);
								}
								resolve();
							} catch (e) {
								reject(e);
							}
						});
					});

					it('should filter observations when an non-existing timeseries is specified', async () => {
						return new Promise(async (resolve, reject) => {
							const list = await observations.list(0, 10, undefined, {
								timeseries: 'f052c4b3-ae8b-43ca-a6f7-ff75fcfc49c5'
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

					it('should throw when an invalid timeseries id is specified', async () => {
						return new Promise(async (resolve, reject) => {
							try {
								await observations.list(0, 10, undefined, {
									timeseries: '%invalid-id'
								});
								reject('did not throw');
							} catch (e) {
								try {
									assert.strictEqual(e.message, 'Invalid timeseries id');
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
							const list = await observations.list(0, 10, undefined, {
								dimensions: {
									sex
								}
							}).catch(reject);
							try {
								assert.strictEqual(list.list.length, 4);
								assert.strictEqual(list.length, 4);
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
							const list = await observations.list(0, 10, undefined, {
								dimensions: {
									sex
								}
							}).catch(reject);
							try {
								assert.strictEqual(list.list.length, 8);
								assert.strictEqual(list.length, 8);
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
							const list = await observations.list(0, 10, undefined, {
								dimensions: {...dimensions}
							}).catch(reject);
							try {
								assert.strictEqual(list.list.length, 2);
								assert.strictEqual(list.length, 2);
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
							const list = await observations.list(0, 10, undefined, {
								dimensions: {...dimensions}
							}).catch(reject);
							try {
								assert.strictEqual(list.list.length, 8);
								assert.strictEqual(list.length, 8);
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
								await observations.list(0, 10, undefined, {
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
								await observations.list(0, 10, undefined, {
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
		let server;

		before(() => {
			server = api.start();
		});

		after(() => {
			server.close();
		});

		describe('Output', () => {
			const observation = '41f7ef3e-2dd1-4864-ac77-5daa4c13f04f';
			const indicator = 'indicator1';
			const timeseries = 'd3a06c6b-82a7-4efa-8f0f-6cb453deff2c';
			const uri = `http://localhost:8000/observations/${observation}`;
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
				assert.strictEqual(body.data.id, observation);
			});

			it('should have the `observation` type', () => {
				assert.strictEqual(body.data.type, 'observation');
			});

			it('should have a link to itself', () => {
				assert.strictEqual(typeof body.data.links, 'object');
				assert.strictEqual(body.data.links.self, uri);
			});

			it('should have a valid ISO date as the `period` attribute', () => {
				const options = {
					year: 'numeric',
					month: '2-digit',
					day: '2-digit'
				};
				assert.notStrictEqual(body.data.attributes.period, undefined);
				assert.strictEqual(body.data.attributes.period, new Date(body.data.attributes.period).toLocaleDateString(undefined, options));
			});

			it('should have an object for the `dimensions` attribute', () => {
				const dimensions = {
					geographicArea: '24'
				};
				assert.strictEqual(typeof body.data.attributes.dimensions, 'object');
				assert.strictEqual(JSON.stringify(body.data.attributes.dimensions), JSON.stringify(dimensions));
			});

			it('should have a a `value` attribute', () => {
				assert.notStrictEqual(body.data.attributes.value, undefined);
			});

			it('should have a a `status` attribute', () => {
				assert.notStrictEqual(body.data.attributes.status, undefined);
			});

			it('should have a valid ISO timestamp as the `dateModified` attribute', () => {
				assert.notStrictEqual(body.data.attributes.dateModified, undefined);
				assert.strictEqual(body.data.attributes.dateModified, new Date(body.data.attributes.dateModified).toISOString());
			});

			it('should have a relationship link to the observations\'s revisions', () => {
				assert.strictEqual(body.data.relationships.revisions.links.self, `${uri}/revisions`);
			});

			it('should have a relationship link to the observations\'s notes', () => {
				assert.strictEqual(body.data.relationships.notes.links.self, `${uri}/notes`);
			});

			it('should have a relationship link to the observations\'s indicator', () => {
				assert.strictEqual(body.data.relationships.indicator.links.self, `http://localhost:8000/indicators/${indicator}`);
			});

			it('should have a relationship reference to the observations\'s indicator', () => {
				assert.strictEqual(body.data.relationships.indicator.data.id, indicator);
				assert.strictEqual(body.data.relationships.indicator.data.type, 'indicator');
			});

			it('should have a relationship link to the observations\'s timeseries', () => {
				assert.strictEqual(body.data.relationships.timeseries.links.self, `http://localhost:8000/timeseries/${timeseries}`);
			});

			it('should have a relationship reference to the observations\'s timeseries', () => {
				assert.strictEqual(body.data.relationships.timeseries.data.id, timeseries);
				assert.strictEqual(body.data.relationships.timeseries.data.type, 'timeseries');
			});
		});

		describe('Routes', () => {
			describe('/observations', () => {
				it.skip('should have tests');
			});

			describe('/observations/:observation_id', () => {
				it.skip('should have tests');
			});

			describe('/observations/:observation_id/revisions', () => {
				it.skip('should have tests');
			});

			describe('/observations/:observation_id/notes', () => {
				it.skip('should have tests');
			});
		});
	});
});

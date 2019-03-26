const xml = require('xml');

function getSeries(serie, status) {
	const s = {
		Series: [
			{
				SeriesKeys: []
			}
		]
	};

	for (const [id, value] of Object.entries(serie.dimensions)) {
		s.Series[0].SeriesKeys.push({
			Value: {
				_attr: {
					id,
					value
				}
			}
		});
	}

	for (const o of serie.observations) {
		const Obs = [
			{
				ObsDimension: {
					_attr: {
						value: o.period
					}
				}
			},
			{
				ObsValue: {
					_attr: {
						value: o.value
					}
				}
			}
		];

		if (o.status) {
			Obs.push({
				Attributes: o.status.map((s) => {
					return {
						Value: {
							_attr: {
								id: 'OBS_STATUS',
								value: status[s]
							}
						}
					};
				})
			});
		}

		s.Series.push({Obs});
	}

	return s;
}

module.exports.convert = function(id, metadata, data, status) {
	const sdmx = {
		'message:GenericData': [
			{
				'_attr': {
					'xmlns:message': 'http://www.sdmx.org/resources/sdmxml/schemas/v2_1/message',
					'xmlns': 'http://www.sdmx.org/resources/sdmxml/schemas/v2_1/data/generic'
				},
			},
			{
				'message:DataSet': []
			}
		]
	};

	const series = {};

	for (const observation of data) {
		const attr = observation.attributes;
		const d = attr.dimensions;
		const strD = JSON.stringify(d);

		if (!series[strD]) {
			series[strD] = {
				dimensions: {...d},
				observations: []
			};
		}
		series[strD].observations.push({
			period: attr.period,
			value: attr.value,
			status: attr.status
		});
	}

	for (const serie of Object.values(series)) {
		sdmx['message:GenericData'][1]['message:DataSet'].push(getSeries(serie, status));
	}

	return xml([sdmx], {declaration: true});
};

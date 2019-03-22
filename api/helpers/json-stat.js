const {getValueIndex, getDimIndices} = require('./json-stat-lib');

function compressMatrix(arr) {
	const compressed = {};
	for (let i = 0; i < arr.length; i++) {
		if (arr[i]) {
			compressed[i] = arr[i];
		}
	}

	return JSON.stringify(compressed).length < JSON.stringify(arr).length ? compressed : arr;
}

module.exports.convert = function(id, metadata, data) {
	const dimension = {
		concept: {
			label: 'concept',
			category: {
				label: id
			}
		}
	};
	const getDimensions = function(d) {
		return {
			period: d.attributes.period,
			...d.attributes.dimensions
		};
	};

	let updated;

	for (let i = 0; i < data.length; i++) {
		const d = data[i];
		const date = new Date(d.attributes.dateModified);

		if (!updated || updated < date)
			updated = date;


		for (const [key, value] of Object.entries(getDimensions(d))) {
			if (!dimension[key]) {
				dimension[key] = {
					category: {
						index: []
					}
				};
			}

			if (!dimension[key].category.index.includes(value)) {
				dimension[key].category.index.push(value);
			}
		}
	}

	const size = Object.values(dimension).slice(1).map((d) => d.category.index.length);
	const valueNumber = size.reduce((sum, l) => sum *= l);
	const value = new Array(valueNumber);
	const status = new Array(valueNumber);
	const jsonStat = {
		version: '2.0',
		class: 'dataset',
		href: `${metadata.links.self}/json-stat`,
		label: metadata.attributes.title,
		updated,
		id: Object.keys(dimension).slice(1),
		size,
		dimension
	};

	for (let i = 0; i < data.length; i++) {
		const d = data[i];
		const dimensions = getDimensions(d);
		const indices = getDimIndices(jsonStat, dimensions);
		const index = getValueIndex(jsonStat, indices);

		value[index] = d.attributes.value;
		status[index] = d.attributes.status;
	}

	jsonStat.value = compressMatrix(value);
	jsonStat.status = compressMatrix(status);

	return jsonStat;
};

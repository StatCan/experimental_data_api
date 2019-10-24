module.exports.format = function(obj) {
	const newObj = {
		...obj,
		attributes: {}
	};

	for (const key of Object.keys(obj)) {
		if (['id', 'type', 'links', 'attributes', 'relationships'].includes(key))
			continue;

		newObj.attributes[key] = obj[key];
		delete newObj[key];
	}

	if (obj.relationships) {
		delete newObj.relationships;
		newObj.relationships = obj.relationships;
	}

	return newObj;
};

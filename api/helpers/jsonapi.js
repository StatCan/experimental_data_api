module.exports.format = function(obj) {
	const newObj = {
		...obj,
		attributes: {}
	};

	for (const key of Object.keys(obj)) {
		if (['id', 'type', 'attributes', 'links'].includes(key))
			continue;

		newObj.attributes[key] = obj[key];
		delete newObj[key];
	}

	return newObj;
};

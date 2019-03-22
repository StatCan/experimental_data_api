/*
JSON-stat JS Sample Code (https://json-stat.org/tools/js)
http://json-stat.org/tools/js.txt
Author: Xavier Badosa (http://xavierbadosa.com)
Date: 2015-12-22
Version: 1.0.1

Copyright 2015 Xavier Badosa
License: Apache License, Version 2.0 http://www.apache.org/licenses/LICENSE-2.0
*/

const getDimIndex = function(dim, name, value) {
	// In single category dimensions, "index" is optional
	if (!dim[name].category.index) {
		return 0;
	}

	const ndx = dim[name].category.index;

	if (Array.isArray(ndx)) {
		return ndx.indexOf(value);
	}

	return ndx[value];
};

const getDimIndices = function(jsonstat, query) {
	const dim = jsonstat.dimension;
	const ids = jsonstat.id || dim.id;
	const arr = [];

	for (let i = 0, len = ids.length; i < len; i++ ) {
		arr[i] = getDimIndex(dim, ids[i], query[ids[i]]);
	}

	return arr;
};

const getValueIndex = function(jsonstat, indices) {
	const size = jsonstat.size || jsonstat.dimension.size;
	const ndims = size.length;
	let num = 0;

	for (let i = 0, mult = 1; i<ndims; i++) {
		mult *= (i>0) ? size[ndims - i] : 1;
		num += mult * indices[ndims - i - 1];
	}

	return num;
};

module.exports = {
	getDimIndex,
	getDimIndices,
	getValueIndex
};

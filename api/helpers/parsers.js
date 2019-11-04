const rangeRegExp = /^(\d{4}-\d{2}(?:-\d{2})?)?\/(\d{4}-\d{2}(?:-\d{2})?)?$/;
const dimensionNameRegExp = /^[aA-zZ0-9\-_]*$/;
const dimensionsValueRegexp = dimensionNameRegExp;

class ParsingError extends Error {}

module.exports.parsePeriod = function(period) {
	const rtn = {};

	if (Array.isArray(period)) {
		period = period[0];
	}

	if (typeof period === 'string') {
		try {
			const [, start, end] = period.match(rangeRegExp);

			if (start)
				rtn.start = new Date(start);

			if (end)
				rtn.end = new Date(end);
		} catch (e) {
			throw new ParsingError('Parameter period is invalid. Period has to be formatted either as \'period=YYYY-MM-DD/YYYY-MM-DD\' or \'period[start]=YYYY-MM-DD&period[end]=YYYY-MM-DD\'');
		}
	} else if (typeof period === 'object') {
		let date;
		if (period.start) {
			date = new Date(Array.isArray(period.start) ? period.start[0] : period.start);

			if (isNaN(date))
				throw new ParsingError('Parameter period[start] is invalid. Expecting date in ISO 8601 format (YYYY-MM-DD)');

			rtn.start = date;
		}

		if (period.end) {
			date = new Date(Array.isArray(period.end) ? period.end[0] : period.end);

			if (isNaN(date))
				throw new ParsingError('Parameter period[end] is invalid. Expecting date in ISO 8601 format (YYYY-MM-DD)');

			rtn.end = date;
		}
	}

	return rtn;
};

module.exports.parseDimensions = function(dimensions) {
	const noObjectTest = (v) => {
		if (typeof v === 'object' && !Array.isArray(v))
			throw new ParsingError(`Nested dimensions values are not supported: ${JSON.stringify(v)}`);
	};

	const validateValue = (v) => {
		if (!dimensionsValueRegexp.test(v))
			throw new ParsingError(`Invalid dimension value: '${v}'`);
	};

	for (let [key, value] of Object.entries(dimensions)) {
		if (!dimensionNameRegExp.test(key))
			throw new ParsingError(`Invalid dimensions name ${key}`);


		if (typeof value === 'string') {
			value = dimensions[key] = value.split(',');
		}

		noObjectTest(value);

		if (Array.isArray(value)) {
			value.forEach((v, i, arr) => {
				noObjectTest(v);
				if (typeof v === 'string') {
					const split = v.split(',');
					if (split.length > 1) {
						split.forEach(validateValue);
						arr.splice(i, 1);
						arr.push(...split);
					} else {
						validateValue(v);
					}
				}
			});
		}
	}

	return dimensions;
};

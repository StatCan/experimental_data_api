const idValidation = /^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$/;

class InvalidTimeseriesIdError extends TypeError {}

const isValid = function(id, throwOnFalse = false) {
	const ret = idValidation.test(id);

	if (!ret && throwOnFalse) {
		throw new InvalidTimeseriesIdError('Invalid timeseries id');
	}

	return ret;
};

module.exports = {
	isValid,
	InvalidTimeseriesIdError
};

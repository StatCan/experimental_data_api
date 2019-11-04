const idValidation = /^[aA-zZ0-9_-]*$/;

class InvalidIndicatorIdError extends TypeError {}

const isValid = function(id, throwOnFalse = false) {
	const ret = idValidation.test(id);

	if (!ret && throwOnFalse) {
		throw new InvalidIndicatorIdError('Invalid indicator id');
	}

	return ret;
};

module.exports = {
	isValid,
	InvalidIndicatorIdError
};

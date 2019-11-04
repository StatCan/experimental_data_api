const idValidation = /^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$/;

class InvalidObservationIdError extends TypeError {}

const isValid = function(id, throwOnFalse = false) {
	const ret = idValidation.test(id);

	if (!ret && throwOnFalse) {
		throw new InvalidObservationIdError('Invalid observation id');
	}

	return ret;
};

module.exports = {
	isValid,
	InvalidObservationIdError
};

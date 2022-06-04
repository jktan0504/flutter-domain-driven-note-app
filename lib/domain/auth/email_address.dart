class EmailAddress {
	final String value;

	/** 
	 * illegal states unpresentatble
	 * **/
	// factory contructor can perform action
	factory EmailAddress(String input) {
		assert(input != null);
		// validate email address
		return EmailAddress._(validateEmailAddress(input));
	}

	const EmailAddress._(this.value);

	@override
	bool operator ==(Object other) {
		if (identical(this, other)) return true;
	
		return other is EmailAddress &&
		other.value == value;
	}

	@override
	int get hashCode => value.hashCode;

	@override
	String toString() => 'EmailAddress(value: $value)';
}

// Validate Email Address
String validateEmailAddress(String input) {
	const emailRegex = r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

	if (RegExp(emailRegex).hasMatch(input)) {
		return input;
	}
	else {
		throw InvalidEmailException(failedValue: input);
	}
}

class InvalidEmailException implements Exception {
	final String failedValue;
	InvalidEmailException({
		required this.failedValue,
	});

	
}

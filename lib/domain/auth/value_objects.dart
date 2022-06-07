import 'package:dartz/dartz.dart';
import 'package:domain_driven/domain/core/failures.dart';
import 'package:domain_driven/domain/core/value_objects.dart';
import 'package:domain_driven/domain/core/value_validators.dart';
import 'package:uuid/uuid.dart';

class EmailAddress extends ValueObject<String> {
	final Either<ValueFailure<String>, String> value;

	// illegal states unpresentatble
	// factory contructor can perform action
	factory EmailAddress(String input) {
		assert(input != null);
		// validate email address
		return EmailAddress._(validateEmailAddress(input));
	}

	const EmailAddress._(this.value);
}

class Password extends ValueObject<String> {
	final Either<ValueFailure<String>, String> value;

	// illegal states unpresentatble
	// factory contructor can perform action
	factory Password(String input) {
		assert(input != null);
		// validate email address
		return Password._(validatePassword(input));
	}

	const Password._(this.value);
}


class UniqueId extends ValueObject<String> {
	@override
	final Either<ValueFailure<String>, String> value;

	factory UniqueId() {
		return UniqueId._(
			right(Uuid().v1()),
		);
	}

	factory UniqueId.fromUniqueString(String uniqueId) {
		assert(uniqueId != null);
		return UniqueId._(
			right(uniqueId),
		);
	}

	const UniqueId._(this.value);
}


// inside UI
// void showingEmailAddressOrFailure() {
// 	final emailAddress = EmailAddress('asd');
// 	String emailText = emailAddress.value.fold(
// 		(l) => 'Failure happend. more precisely: $l', 
// 		(r) => r
// 	);
// 	String emailtxt = emailAddress.value.getOrElse(() => 'Some Failure happened');
// }
import 'package:domain_driven/domain/core/failures.dart';

class UnexpectedValueError extends Error {
	final ValueFailure valueFailure;

	UnexpectedValueError(this.valueFailure);

  	@override
  	String toString() => Error.safeToString('UnexpectedValueError occur. Terminating: $valueFailure');
}

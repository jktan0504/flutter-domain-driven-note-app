import 'package:dartz/dartz.dart';
import 'package:domain_driven/domain/core/failures.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ValueObject<T> {
	const ValueObject();
	Either<ValueFailure<T>, T> get value;

	bool isValid() => value.isRight();

	@override
	bool operator ==(Object other) {
		if (identical(this, other)) return true;
	
		return other is ValueObject<T> &&
		other.value == value;
	}

	@override
	int get hashCode => value.hashCode;

	@override
	String toString() => 'Value Object(value: $value)';
		
}
import 'package:dartz/dartz.dart';
import 'package:domain_driven/domain/auth/auth_failures.dart';
import 'package:domain_driven/domain/auth/value_objects.dart';

abstract class IAuthFacade {
	Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
		required EmailAddress email,
		required Password password
	});

	Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
		required EmailAddress email,
		required Password password
	});

	Future<Either<AuthFailure, Unit>> signInWithGoogle();
}
import 'package:dartz/dartz.dart';
import 'package:domain_driven/domain/auth/auth_failures.dart';
import 'package:domain_driven/domain/auth/value_objects.dart';
import 'package:domain_driven/domain/auth/user.dart';

abstract class IAuthFacade {
	
	Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
		required EmailAddress emailAddress,
		required Password password
	});

	Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
		required EmailAddress emailAddress,
		required Password password
	});

	Future<Either<AuthFailure, Unit>> signInWithGoogle();

	Future<Option<User>> getSignedInUser();

	 Future<void> signOut();
}
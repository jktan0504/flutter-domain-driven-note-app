import 'dart:developer';

import 'package:domain_driven/domain/auth/auth_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain_driven/domain/auth/i_auth_facade.dart';
import 'package:domain_driven/domain/auth/value_objects.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@lazySingleton  
@Injectable(as: IAuthFacade)
class FirebaseAuthFacade implements IAuthFacade {
	final FirebaseAuth _firebaseAuth;
	final GoogleSignIn _googleSignIn;

	FirebaseAuthFacade(
		this._firebaseAuth, 
		this._googleSignIn
	);

	@override
	Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
		required EmailAddress emailAddress, 
		required Password password
	}) async {
		try {
			final emailStr = emailAddress.getOrCrash();
			final passwordStr = password.getOrCrash();
			
			await _firebaseAuth.createUserWithEmailAndPassword(email: emailStr, password: passwordStr);

			return right(unit);
		} on PlatformException catch (e) {
			if (e.code == 'email-already-in-use') {
				return left(const AuthFailure.emailAlreadyInUse());
			}
			else {
				return left(const AuthFailure.serverError());
			}
		}
	}

	@override
	Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
		required EmailAddress emailAddress, 
		required Password password
	}) async {
		try {
			final emailStr = emailAddress.getOrCrash();
			final passwordStr = password.getOrCrash();
			
			await _firebaseAuth.signInWithEmailAndPassword(email: emailStr, password: passwordStr);

			return right(unit);
		} on PlatformException catch (e) {
			if (e.code == 'invalid-email' || e.code == 'wrong-password' || e.code == 'user-not-found') {
				return left(const AuthFailure.invalidEmailAndPasswordCombination());
			}
			else {
				return left(const AuthFailure.serverError());
			}
		}
	}

	@override
	Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
		try {
			final googleCurrentUser = await _googleSignIn.signIn();
			// ignore: unnecessary_null_comparison
			if (googleCurrentUser == null) {
				return left(const AuthFailure.serverError());
			}
			final googleAuthentication = await googleCurrentUser.authentication;
			final authCredential = GoogleAuthProvider.credential(accessToken: googleAuthentication.accessToken, idToken: googleAuthentication.idToken);

			return _firebaseAuth.signInWithCredential(authCredential).then((r) => right(unit));
		} on PlatformException catch (e) {
			// ignore: avoid_print
			log(e.toString());
			return left(const AuthFailure.serverError());
		}
	}
}
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domain_driven/domain/auth/auth_failures.dart';
import 'package:domain_driven/domain/auth/i_auth_facade.dart';
import 'package:domain_driven/domain/auth/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

part 'sign_in_form_bloc.freezed.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {

	final IAuthFacade _authFacade;

	SignInFormBloc(this._authFacade) : super(SignInFormState.initial()) {
		on<EmailChanged>((event, emit) => {
			emit(state.copyWith(
				emailAddress: EmailAddress(event.emailStr),
				authFailureOrSuccessOption: none(),
			))
		});

		on<PasswordChanged>((event, emit) => {
			emit(state.copyWith(
				password: Password(event.passwordStr),
				authFailureOrSuccessOption: none(),
			))
		});

		// Original
		// on<RegisterWithEmailAndPasswordPressed>((event, emit) async {
		// 	final Unit someData = none() as Unit;
		// 	Either<AuthFailure, Unit> failureOrSuccess = right(someData);
		// 	final isEmailValid = state.emailAddress.isValid();
		// 	final isPasswordValid = state.password.isValid();

		// 	if (isEmailValid && isPasswordValid) {
		// 		emit(state.copyWith(
		// 			isSubmitting: true,
		// 			authFailureOrSuccessOption: none()
		// 		));

		// 		failureOrSuccess = await _authFacade.registerWithEmailAndPassword(emailAddress: state.emailAddress, password: state.password);
		// 	}

		// 	emit(state.copyWith(
		// 		isSubmitting: false,
		// 		showErrorMessages: true,
		// 		// ignore: unnecessary_null_comparison
		// 		// failureOrSuccess == null ? none() : some(failureOrSuccess) ==== optionOf(failureOrSuccess)
		// 		authFailureOrSuccessOption: optionOf(failureOrSuccess), // return none() or failureOfSuccess Unit
		// 	));
			
		// });

		// ignore: void_checks
		// on<RegisterWithEmailAndPasswordPressed>((event, emit) async* {

		// 	print("event is reached RegisterWithEmailAndPasswordPressed");
		// 	yield* _performActionOnAuthFacadeWithEmailAndPassword(
		// 		_authFacade.registerWithEmailAndPassword
		// 	);		
		// });
		// ignore: void_checks good 
		// on<RegisterWithEmailAndPasswordPressed>((event, emit) async* {
		// 	print("event is running");
		// 	yield* _performActionOnAuthFacadeWithEmailAndPassword(
		// 		_authFacade.registerWithEmailAndPassword
		// 	);		
		// });
		on<RegisterWithEmailAndPasswordPressed>((event, emit) async  {

			Either<AuthFailure, Unit>? failureOrSuccess;

			final isEmailValid = state.emailAddress.isValid();
			final isPasswordValid = state.password.isValid();

			if (isEmailValid && isPasswordValid) {
				print("valid");
				emit(state.copyWith(
					isSubmitting: true,
					authFailureOrSuccessOption: none(),
				));

				failureOrSuccess = await _authFacade.registerWithEmailAndPassword(
					emailAddress: state.emailAddress,
					password: state.password,
				);
				print(failureOrSuccess);
			}
			else {
				print("invalid");	
			}

			emit(state.copyWith(
				isSubmitting: false,
				showErrorMessages: true,
				// ignore: unnecessary_null_comparison
				// failureOrSuccess == null ? none() : some(failureOrSuccess) ==== optionOf(failureOrSuccess)
				authFailureOrSuccessOption: optionOf(failureOrSuccess),
			));
		});


		// ignore: void_checks
		on<SignInWithEmailAndPasswordPressed>((event, emit) async {
			Either<AuthFailure, Unit>? failureOrSuccess;

			final isEmailValid = state.emailAddress.isValid();
			final isPasswordValid = state.password.isValid();

			if (isEmailValid && isPasswordValid) {
				print("valid");
				emit(state.copyWith(
					isSubmitting: true,
					authFailureOrSuccessOption: none(),
				));

				failureOrSuccess = await _authFacade.signInWithEmailAndPassword(
					emailAddress: state.emailAddress,
					password: state.password,
				);
				print(failureOrSuccess);
			}
			else {
				print("invalid");	
			}

			emit(state.copyWith(
				isSubmitting: false,
				showErrorMessages: true,
				// ignore: unnecessary_null_comparison
				// failureOrSuccess == null ? none() : some(failureOrSuccess) ==== optionOf(failureOrSuccess)
				authFailureOrSuccessOption: optionOf(failureOrSuccess),
			));		
		});
		
		on<SignInWithGooglePressed>((event, emit) async {
			emit(state.copyWith(
				isSubmitting: true,
				authFailureOrSuccessOption: none()
			));
			final failureOrSuccess = await _authFacade.signInWithGoogle();
			emit(state.copyWith(
				isSubmitting: false,
				authFailureOrSuccessOption: some(failureOrSuccess)
			));
		});
	}

	Stream<SignInFormState> _performActionOnAuthFacadeWithEmailAndPassword(
		Future<Either<AuthFailure, Unit>> Function({
			required EmailAddress emailAddress,
			required Password password,
		})
			forwardedCall,
	) async* {
		final Unit someData = none() as Unit;
		Either<AuthFailure, Unit> failureOrSuccess = right(someData);

		final isEmailValid = state.emailAddress.isValid();
		final isPasswordValid = state.password.isValid();

		if (isEmailValid && isPasswordValid) {
			print("valid");
			yield state.copyWith(
				isSubmitting: true,
				authFailureOrSuccessOption: none(),
			);

			failureOrSuccess = await forwardedCall(
				emailAddress: state.emailAddress,
				password: state.password,
			);
		}
		else {
			print("invalid");
		}

		yield state.copyWith(
			isSubmitting: false,
			showErrorMessages: true,
			// ignore: unnecessary_null_comparison
			// failureOrSuccess == null ? none() : some(failureOrSuccess) ==== optionOf(failureOrSuccess)
			authFailureOrSuccessOption: optionOf(failureOrSuccess),
		);
	}
}


import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domain_driven/domain/auth/auth_failures.dart';
import 'package:domain_driven/domain/auth/i_auth_facade.dart';
import 'package:domain_driven/domain/auth/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

part 'sign_in_form_bloc.freezed.dart';

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
		on<RegisterWithEmailAndPasswordPressed>((event, emit) async* {
			yield* _performActionOnAuthFacadeWithEmailAndPassword(
				_authFacade.registerWithEmailAndPassword,
				emit
			);		
		});


		// ignore: void_checks
		on<SignInWithEmailAndPasswordPressed>((event, emit) async* {
			yield* _performActionOnAuthFacadeWithEmailAndPassword(
				_authFacade.signInWithEmailAndPassword,
				emit
			);		
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
			required Password password
		})
		forwardCall,
		Emitter<SignInFormState> emit, 
	) async* {
		final Unit someData = none() as Unit;
		Either<AuthFailure, Unit> failureOrSuccess = right(someData);
		final isEmailValid = state.emailAddress.isValid();
		final isPasswordValid = state.password.isValid();

		if (isEmailValid && isPasswordValid) { 
			emit(state.copyWith(
					isSubmitting: true,
					authFailureOrSuccessOption: none()
				));

				failureOrSuccess = await forwardCall(emailAddress: state.emailAddress, password:  state.password);
			}

			emit(state.copyWith(
				isSubmitting: false,
				showErrorMessages: true,
				// ignore: unnecessary_null_comparison
				// failureOrSuccess == null ? none() : some(failureOrSuccess) ==== optionOf(failureOrSuccess)
				authFailureOrSuccessOption: optionOf(failureOrSuccess), // return none() or failureOfSuccess Unit
			));
	}
}


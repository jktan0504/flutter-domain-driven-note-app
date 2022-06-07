import 'package:domain_driven/domain/auth/auth_failures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/auth/sign_in_form/sign_in_form_bloc.dart';

class SignInForm extends StatelessWidget {
	const SignInForm({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return BlocConsumer<SignInFormBloc, SignInFormState>(
			listener: (context, state) {
				state.authFailureOrSuccessOption.fold(
					// failure
					() => {}, 
					// sum with unit
					(either) => either.fold(
						(failure) {
							final snackBar = SnackBar(
								content: Text(failure.map(
									cancelledlByUser: (_) => 'Cancel By User', 
									serverError: (_) => 'Server Error',
									emailAlreadyInUse: (_) => 'Email is already in use', 
									invalidEmailAndPasswordCombination: (_) => 'Invalid email & password'
								)),
								action: SnackBarAction(
									label: 'Error',
									onPressed: () => {}
								),
							);

							// Find the ScaffoldMessenger in the widget tree
							// and use it to show a SnackBar.
							ScaffoldMessenger.of(context).showSnackBar(snackBar);
						}, 

						// TODO: navigation to main route
						(r) => null
					),
				);
			},
			builder: (context, state) {
				return Form(
					autovalidateMode: AutovalidateMode.always,
					child: ListView(
						children: [
							const Text(
								'📝',
								textAlign: TextAlign.center,
								style: TextStyle(fontSize: 130),
							),
							const SizedBox(height: 8),
							TextFormField(
								decoration: const InputDecoration(
								prefixIcon: Icon(Icons.email),
								labelText: 'Email',
								),
								autocorrect: false,
								onChanged: (value) => context.read<SignInFormBloc>()
									.add(EmailChanged(emailStr: value)),
								validator: (_) => context.watch<SignInFormBloc>()
									.state.emailAddress.value.fold(
										(f) => f.maybeMap(
											invalidEmail: (_) => 'Invalid Email',
											orElse: () => null
										), 
										(_) => null,
									),
							),
							const SizedBox(height: 8),
							TextFormField(
								decoration: const InputDecoration(
								prefixIcon: Icon(Icons.lock),
								labelText: 'Password',
								),
								autocorrect: false,
								obscureText: true,
								onChanged: (value) => context.read<SignInFormBloc>()
									.add(PasswordChanged(passwordStr: value)),
								validator: (_) => context.watch<SignInFormBloc>()
									.state.password.value.fold(
										(failed) => failed.maybeMap(
											shortPassword: (_) => 'Short Password',
											orElse: () => null
										), 
										(r) => null
									),
							),
							const SizedBox(height: 8),
							Row(
								children: [
									Expanded(
										child: ElevatedButton(
											style: ElevatedButton.styleFrom(
												primary: Colors.teal,
												fixedSize: const Size.fromWidth(100),
												padding: const EdgeInsets.all(10)
											),
											child:const Text('SIGN IN'),
											onPressed: () => {
												context.read<SignInFormBloc>().add(const SignInFormEvent.signInWithEmailAndPasswordPressed())

											},
										),
									),
									const SizedBox(width: 10.0,),
									Expanded(
										child: ElevatedButton(
											style: ElevatedButton.styleFrom(
												primary: Colors.teal,
												fixedSize: const Size.fromWidth(100),
												padding: const EdgeInsets.all(10)
											),
											child: const Text("REGISTER"),
											onPressed: () {
												print("Register Pressed");
												context.read<SignInFormBloc>().add(const RegisterWithEmailAndPasswordPressed());

											},
										),
									),
								],
							),
							ElevatedButton(
								style: ElevatedButton.styleFrom(
									primary: Colors.teal,
									fixedSize: const Size.fromWidth(100),
									padding: const EdgeInsets.all(10)
								),
								child: const Text('SIGN IN WITH GOOGLE'),
								onPressed: () => {
									context.read<SignInFormBloc>().add(const SignInFormEvent.signInWithGooglePressed())
								},
							),
							if (state.isSubmitting) ...[
								const SizedBox(height: 8),
								const LinearProgressIndicator(value: null),
							]
						]
					)
				);
			},
		);
  	}
}
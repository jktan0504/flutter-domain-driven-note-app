import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
	const SignInPage({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text("Sign In"),
			),
			body: BlocProvider(
				create: (context) => getIt<SignInFormBloc>(),
				child: SignInForm(),
			),
		);
	}
}
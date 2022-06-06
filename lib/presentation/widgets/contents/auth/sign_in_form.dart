import 'package:flutter/material.dart';

class SignInForm extends StatelessWidget {
	const SignInForm({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return BlocConsumer<SignInFormBloc, SignInFormState>(
			listener: (context, state) {
				// TODO: implement listener
			},
			builder: (context, state) {
				return Form(
					child: ListView(
						children: [
							const Text("note"),
						]
					)
				);
			},
		);
  	}
}
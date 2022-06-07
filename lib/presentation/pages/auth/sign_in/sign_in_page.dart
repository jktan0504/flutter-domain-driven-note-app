import 'package:domain_driven/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:domain_driven/core/injector/injector.dart';
import 'package:domain_driven/presentation/widgets/contents/auth/sign_in_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
	const SignInPage({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return BlocProvider(
			create: (context) => getIt<SignInFormBloc>(),
			child: Scaffold(
				appBar: AppBar(
					title: const Text("ToDo Notes"),
				),
				body: Container(
					padding: const EdgeInsets.all(15.0),
					child: const SignInForm(),
				),
			),
		);
	}
}
import 'package:domain_driven/presentation/pages/auth/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';

class NoteApp extends StatelessWidget {
	const NoteApp({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Notes',
			home: const SignInPage(),
			theme: ThemeData.light().copyWith(
				colorScheme: ColorScheme.fromSwatch().copyWith(
					primary: Colors.green[800],
					secondary: Colors.red, // Your accent color
				),
				inputDecorationTheme: InputDecorationTheme(
					border: OutlineInputBorder(
						borderRadius: BorderRadius.circular(8.0)
					)
				),
			),
		);	
  	}	
}
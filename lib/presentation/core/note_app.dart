import 'package:domain_driven/presentation/pages/auth/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';

class NoteApp extends StatelessWidget {
	const NoteApp({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Note App',
			home: SignInPage(),
		);	
  	}	
}
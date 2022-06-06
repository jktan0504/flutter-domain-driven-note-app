import 'package:domain_driven/core/injector/injector.dart';
import 'package:domain_driven/presentation/core/note_app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'firebase_options.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await Firebase.initializeApp(
		options: DefaultFirebaseOptions.currentPlatform,
	);
	configureDependencies(Environment.prod);
  	runApp(const NoteApp());
}


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:notes_app/screens/auth_wrapper.dart';
// import 'package:notes_app/services/auth_provider.dart';
import 'package:provider/provider.dart';

import 'AuthProvider.dart';
import 'auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthWrapper(),
      ),
    );
  }
}

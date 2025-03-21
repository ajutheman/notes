import 'package:flutter/material.dart';
// import 'package:notes_app/screens/home_screen.dart';
// import 'package:notes_app/screens/login_screen.dart';
// import 'package:notes_app/services/auth_provider.dart';
import 'package:provider/provider.dart';

import 'AuthProvider.dart';
import 'screen/home_screen.dart';
import 'screen/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;
    return user != null ? HomeScreen() : LoginScreen();
  }
}

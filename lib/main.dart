import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AuthProvider.dart'; // Make sure the path is correct
import 'app.dart';
import 'core/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.init();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

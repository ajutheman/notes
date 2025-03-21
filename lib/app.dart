import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/screen/login_screen.dart';

import 'logic/blocs/auth_bloc.dart';
import 'logic/blocs/auth_event.dart';
import 'logic/data/repositories/auth_repository.dart';
import 'logic/data/repositories/notes_repository.dart';
// import 'data/repositories/auth_repository.dart';
// import 'data/repositories/notes_repository.dart';
// import 'logic/blocs/auth_bloc/auth_bloc.dart';
// import 'presentation/screens/auth/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => NotesRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  AuthBloc(authRepository: context.read<AuthRepository>())
                    ..add(AppStarted())),
        ],
        child: MaterialApp(
          title: 'Notes App',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: LoginScreen(),
        ),
      ),
    );
  }
}

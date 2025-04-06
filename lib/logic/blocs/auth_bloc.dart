import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../data/repositories/auth_repository.dart';
import '../../core/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AppStarted>((_, emit) async {
      emit(AuthLoading());
      final user = authRepository.getCurrentUser();
      user != null ? emit(Authenticated(user)) : emit(Unauthenticated());
    });

    on<LoggedIn>((event, emit) async {
      emit(AuthLoading());
      try {
        final user =
            await authRepository.signInWithEmail(event.email, event.password);
        emit(Authenticated(user));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user =
            await authRepository.signUpWithEmail(event.email, event.password);
        emit(Authenticated(user));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<GoogleSignInRequested>((_, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.signInWithGoogle();
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(const AuthFailure("Google Sign-In aborted."));
        }
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<LoggedOut>((_, emit) async {
      emit(AuthLoading());
      await authRepository.signOut();
      emit(Unauthenticated());
    });
  }
}

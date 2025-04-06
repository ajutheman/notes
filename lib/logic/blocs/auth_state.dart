// import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// abstract class AuthState extends Equatable {
//   const AuthState();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class AuthInitial extends AuthState {}
//
// class AuthLoading extends AuthState {}
//
// class Authenticated extends AuthState {
//   final User user;
//
//   const Authenticated(this.user);
//
//   @override
//   List<Object?> get props => [user];
// }
//
// class AuthFailure extends AuthState {
//   final String error;
//
//   const AuthFailure(this.error);
//
//   @override
//   List<Object?> get props => [error];
// }
//
// class Unauthenticated extends AuthState {}
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final User user;

  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class Unauthenticated extends AuthState {}

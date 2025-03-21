import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;

  Future<void> signup(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = result.user;
      if (user != null) {
        print("✅ Sign Up Successful!");
        print("User UID: ${user.uid}");
        print("User Email: ${user.email}");
        print("Sign up at: ${DateTime.now()}");
      }
      notifyListeners();
    } catch (e) {
      print("❗ Signup Error: $e");
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = result.user;
      if (user != null) {
        print("✅ Login Successful!");
        print("User UID: ${user.uid}");
        print("User Email: ${user.email}");
        print("Login time: ${DateTime.now()}");
      }
      notifyListeners();
    } catch (e) {
      print("❗ Login Error: $e");
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      print("🔓 User logged out at: ${DateTime.now()}");
      notifyListeners();
    } catch (e) {
      print("❗ Logout Error: $e");
      rethrow;
    }
  }
}

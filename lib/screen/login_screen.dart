// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:note/signup_screen.dart';
// // import 'package:notes_app/screens/signup_screen.dart';
// // import 'package:notes_app/services/auth_provider.dart';
// import 'package:provider/provider.dart';
//
// import 'AuthProvider.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);
//     return Scaffold(
//       appBar: AppBar(title: Text("Login")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: "Email")),
//             TextField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(labelText: "Password")),
//             SizedBox(height: 20),
//             isLoading
//                 ? CircularProgressIndicator()
//                 : ElevatedButton(
//                     onPressed: () async {
//                       setState(() => isLoading = true);
//                       try {
//                         await authProvider.login(_emailController.text.trim(),
//                             _passwordController.text.trim());
//                       } catch (e) {
//                         Fluttertoast.showToast(msg: "Login failed: $e");
//                       }
//                       setState(() => isLoading = false);
//                     },
//                     child: Text("Login"),
//                   ),
//             TextButton(
//               onPressed: () => Navigator.push(
//                   context, MaterialPageRoute(builder: (_) => SignUpScreen())),
//               child: Text("Don't have an account? Sign Up"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../AuthProvider.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    hintText: "Email",
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.email, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    hintText: "Password",
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 30),
                isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.9),
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 80),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 5,
                        ),
                        onPressed: () async {
                          setState(() => isLoading = true);
                          try {
                            await authProvider.login(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            );
                            Fluttertoast.showToast(
                                msg: "✅ Login Successful",
                                backgroundColor: Colors.green);
                          } catch (e) {
                            Fluttertoast.showToast(
                                msg: "❗ Login failed: $e",
                                backgroundColor: Colors.red);
                          }
                          setState(() => isLoading = false);
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SignUpScreen()),
                  ),
                  child: const Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

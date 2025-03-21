import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../AuthProvider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _iconAnimationController;

  @override
  void initState() {
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    super.initState();
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;
    final userInitial = user?.email != null && user!.email!.isNotEmpty
        ? user.email![0].toUpperCase()
        : '?';

    final lastLoginDate = user?.metadata.lastSignInTime != null
        ? DateFormat('MMM d, yyyy – hh:mm a').format(
            user!.metadata.lastSignInTime!,
          )
        : 'Not available';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("My Profile"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 100,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white24, Colors.white10],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 14,
                        offset: const Offset(3, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF6A11CB),
                              Color(0xFF2575FC),
                            ],
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.white,
                          child: Text(
                            userInitial,
                            style: const TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 42,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 700),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        child: Text(user?.email ?? 'No email found'),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Last login: $lastLoginDate",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 28),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          elevation: 5,
                        ),
                        onPressed: () async {
                          _iconAnimationController.repeat();
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Logout Confirmation"),
                              content: const Text(
                                  "Are you sure you want to logout?"),
                              actions: [
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                ),
                                TextButton(
                                  child: const Text("Logout"),
                                  onPressed: () => Navigator.pop(context, true),
                                ),
                              ],
                            ),
                          );
                          _iconAnimationController.stop();
                          if (confirm == true) {
                            await authProvider.logout();
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                          }
                        },
                        icon: AnimatedBuilder(
                          animation: _iconAnimationController,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _iconAnimationController.value * 6.3, // 2π
                              child: child,
                            );
                          },
                          child: const Icon(Icons.logout),
                        ),
                        label: const Text(
                          "Logout",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

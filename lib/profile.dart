import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'firebase_error.dart';
import 'reset_password.dart';
import 'user_roles.dart';
import 'welcome.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDarkMode = false;
  bool _isProfileLoading = true;
  String _name = "User";
  String _email = "";
  String _role = roleLabel(defaultUserRole);

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      setState(() {
        _isProfileLoading = false;
      });
      return;
    }

    var name = user.displayName ?? "User";
    var email = user.email ?? "";
    var role = roleLabel(defaultUserRole);

    try {
      final snapshot = await FirebaseDatabase.instance
          .ref('users/${user.uid}')
          .get();
      final value = snapshot.value;

      if (value is Map) {
        final savedName = value['name']?.toString();
        final savedEmail = value['email']?.toString();
        final savedRole = value['role']?.toString();

        if (savedName != null && savedName.isNotEmpty) {
          name = savedName;
        }

        if (savedEmail != null && savedEmail.isNotEmpty) {
          email = savedEmail;
        }

        if (savedRole != null && savedRole.isNotEmpty) {
          role = roleLabel(savedRole);
        }
      }

      if (!mounted) {
        return;
      }

      setState(() {
        _name = name;
        _email = email;
        _role = role;
        _isProfileLoading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _name = name;
        _email = email;
        _role = role;
        _isProfileLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(firebaseErrorMessage(error)),
        ),
      );
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

    if (!mounted) {
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const WelcomePage(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text("Profile & Settings"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const CircleAvatar(
                radius: 55,
                backgroundColor: Colors.purple,
                child: Icon(
                  Icons.person,
                  size: 70,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                _isProfileLoading ? "Loading..." : _name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                _isProfileLoading ? "" : _email,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                _isProfileLoading ? "" : _role,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.brown,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 35),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[100],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Account",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    ListTile(
                      leading: const Icon(Icons.key),
                      title: const Text(
                        "Change Password",
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ResetPasswordPage(),
                          ),
                        );
                      },
                    ),

                    const ListTile(
                      leading: Icon(Icons.edit),
                      title: Text("Edit Profile"),
                    ),

                    const SizedBox(height: 20),

                    const Center(
                      child: Text(
                        "Theme",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: IconButton(
                              icon: const Icon(
                                Icons.light_mode,
                              ),
                              onPressed: () {
                                setState(() {
                                  isDarkMode = false;
                                });
                              },
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: IconButton(
                              icon: const Icon(
                                Icons.dark_mode,
                              ),
                              onPressed: () {
                                setState(() {
                                  isDarkMode = true;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Center(
                      child: Text(
                        "Language",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Center(
                                child: Text("ENG"),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: VerticalDivider(
                              color: Colors.grey,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Center(
                                child: Text("ARB"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                        onPressed: logout,
                        child: const Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              Row(
                children: [
                  const Icon(
                    Icons.help_outline,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 9),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Need help?",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'welcome.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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

      drawer: Drawer(
        child: Stack(
          children: [
            SizedBox.expand(
              child: Image.asset(
                'assets/bg.jpg',
                fit: BoxFit.cover,
              ),
            ),

            Container(
              color: Colors.white.withOpacity(0.90),
            ),

            ListView(
              padding: EdgeInsets.zero,

              children: [

                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),

                  child: Align(
                    alignment: Alignment.topLeft,

                    child: Icon(
                      Icons.menu,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),

                drawerItem(
                  icon: Icons.home,
                  title: "Home",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                drawerItem(
                  icon: Icons.music_note,
                  title: "About Oman",
                  onTap: () => showComingSoon("About Oman"),
                ),

                drawerItem(
                  icon: Icons.explore,
                  title: "Explore",
                  onTap: () => showComingSoon("Explore"),
                ),

                drawerItem(
                  icon: Icons.event,
                  title: "Events",
                  onTap: () => showComingSoon("Events"),
                ),

                drawerItem(
                  icon: Icons.notifications,
                  title: "Notifications",
                  onTap: () => showComingSoon("Notifications"),
                ),

                ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.brown,
                  ),

                  title: const Text(
                    "Profile & Settings",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const ProfilePage(),
                      ),
                    );
                  },
                ),

                drawerItem(
                  icon: Icons.help,
                  title: "Help & Support",
                  onTap: () => showComingSoon("Help & Support"),
                ),

                drawerItem(
                  icon: Icons.info,
                  title: "About us",
                  onTap: () => showComingSoon("About us"),
                ),

                const SizedBox(height: 20),

                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),

                  title: const Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  onTap: logout,
                ),
              ],
            ),
          ],
        ),
      ),

      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text("Explore Oman"),
        centerTitle: true,
      ),

      body: Stack(
        fit: StackFit.expand,

        children: [

          Image.asset(
            'assets/bg.jpg',
            fit: BoxFit.cover,
          ),

          Container(
            color: Colors.black.withOpacity(0.4),
          ),

          const Center(
            child: Padding(
              padding: EdgeInsets.all(20),

              child: Text(
                "Welcome to Oman Culture Exploration App",
                textAlign: TextAlign.center,

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {

    return ListTile(
      leading: Icon(
        icon,
        color: Colors.brown,
      ),

      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

      onTap: onTap,
    );
  }

  void showComingSoon(String pageName) {
    Navigator.pop(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$pageName page coming soon"),
        ),
      );
    });
  }
}

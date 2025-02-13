import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;

  @override
  void initState() {
    super.initState();
    // Get the current user at the start
    user = FirebaseAuth.instance.currentUser;
  }

  // Sign the user out
  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    // After sign out, set the user to null and rebuild
    setState(() {
      user = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: user == null
            ? const Text("You are logged out.")
            : Text(
                "LOGGED IN AS : ${user!.email}",
                style: const TextStyle(fontSize: 20),
              ),
      ),
    );
  }
}

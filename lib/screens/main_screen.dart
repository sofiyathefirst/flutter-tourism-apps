import 'package:flutter/material.dart';
import 'package:test_project/screens/profile_page.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const ProfilePage();
            }),
          ),
        ),
      ),
      backgroundColor: Colors.orangeAccent,
      body: const Center(
        child: Text('Welcome!'),
      ),
    );
  }
}

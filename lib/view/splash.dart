import 'package:flutter/material.dart';

import 'home_page.dart';


class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigater();
  }

  Future<void> _navigater() async {
    await Future.delayed(const Duration(seconds: 3));
    // User is logged in, navigate to NewsRoom
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/music_bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      // child: Padding(
      //   padding: const EdgeInsets.only(bottom: 20),
      //   child: Align(
      //     alignment: Alignment.bottomCenter,
      //     child: const Text(
      //       "Welcome to Music\nApp",
      //       style: TextStyle(
      //         color: Colors.white,
      //         fontSize: 24,
      //       ),
      //       textAlign: TextAlign.center, // Adjust alignment if needed
      //     ),
      //   ),
      // ),
    );
  }
}
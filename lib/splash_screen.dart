import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // Wait for a few seconds and check login status
    Future.delayed(Duration(seconds: 5), () {
      // Check if the user is logged in
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Navigate to HomeScreen if the user is logged in
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        // Navigate to LoginScreen if the user is not logged in
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          // Overlay with text and spinner
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Column(
                children: [
                  Image(
                      height: 120,
                      width: 120,
                      image: AssetImage("images/img.png")),
                  SizedBox(height: 10,),
                  const Text('Task Manager', style: TextStyle(
                    color: Color(0xFF008891),
                    fontSize: 35,
                      letterSpacing: 2.5,
                      shadows: [
                        Shadow(
                        blurRadius: 10.0,
                          color: Colors.black54,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              // Spacer to control the distance between the title and spinner
              //Spacer(flex: 1),
              SizedBox(
                height: 200,
              ),
              // Loading spinner in the center
              SpinKitChasingDots(
                color: Color(0xFF008891),
                size: 50,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

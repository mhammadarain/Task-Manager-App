import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/services/auth_service.dart';
import 'package:task_manager/signup_screen.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 80,),
                  Image(
                      height: 100,
                      width: 100,
                      image: AssetImage("images/img.png")),
                  SizedBox(width: 10,),

              const SizedBox(height: 20,),
              const Center(child: Text('Login Here', style:
              TextStyle(color: Color(0xFF008891),
                fontSize: 30,
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
              ),),

              const SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: const Color(0xffF8F9FA),
                    filled: true,
                    prefixIcon: const Icon(Icons.email_outlined,color: Color(0xff323F4B),),
                    focusedBorder: OutlineInputBorder(
                      borderSide:const BorderSide(color: Color(0xffE4E7EB)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:const BorderSide(color: Color(0xffE4E7EB)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    fillColor: const Color(0xffF8F9FA),
                    filled: true,
                    prefixIcon: const Icon(Icons.lock_outline,color: Color(0xff323F4B),),
                    focusedBorder: OutlineInputBorder(
                      borderSide:const BorderSide(color: Color(0xffE4E7EB)),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:const BorderSide(color: Color(0xffE4E7EB)),
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
              ),



              const SizedBox(height: 40,),

              GestureDetector(
                onTap: ()async {
                  User? user = await _auth.signInWithEmailAndPassword(_emailController.text, _passController.text);
                  if (user != null) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  }
                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      color: const Color(0xFF008891),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Center(
                    child: Text("Login",style: TextStyle(
                        fontFamily: "Rubik Regular",
                        color: Colors.white
                    ),),
                  ),
                ),
              ),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Dont have an account?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff203142),
                      fontFamily: "Rubik Regular",
                    ),),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignupScreen()));
                    },
                    child: const Text("Sign Up ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Rubik Medium",
                          color: Color(0xFF008891)
                      ),),
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

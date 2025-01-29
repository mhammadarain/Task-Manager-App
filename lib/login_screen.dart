import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/services/auth_service.dart';

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
      backgroundColor: Color(0xFF1d2630),
      appBar: AppBar(
        backgroundColor: Color(0xFF1d2630),
        foregroundColor: Colors.white,
        title: Text("Login Account"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Text("Login Here",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
              SizedBox(height: 20,),
              TextField(
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                obscureText: false,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white60)
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText:'Email',
                    labelStyle:TextStyle(color: Colors.white60)
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _passController,
                style: TextStyle(color: Colors.white),
                obscureText: false,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white60)
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText:'Password',
                    labelStyle:TextStyle(color: Colors.white60)
                ),
              ),
              SizedBox(height: 50,),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width/1.5,
                child: ElevatedButton(onPressed: ()async{
                  User? user = await _auth.signInWithEmailAndPassword(_emailController.text, _passController.text);
                  if(user != null){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  }
                }, child: Text("Login",style: TextStyle(color: Colors.indigo),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

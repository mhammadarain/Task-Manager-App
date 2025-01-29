import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/home_screen.dart';
import 'package:task_manager/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/provider/theme_provider.dart';
import 'package:task_manager/services/theme_data.dart';
import 'package:task_manager/signup_screen.dart';
import 'package:task_manager/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( ChangeNotifierProvider(
    create: (context)=> ThemeProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget{
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager App',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeProvider.themeMode,
      //home: _auth.currentUser != null ? HomeScreen(): LoginScreen(),// Change to LoginScreen() if needed
      home: SplashScreen(),
    );
  }
}
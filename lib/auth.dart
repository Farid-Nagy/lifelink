//import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'screen/home_screen.dart';
//import 'screen/login_screen.dart';

//class Auth extends StatelessWidget {
//  const Auth({super.key});

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: StreamBuilder<User?>(
//        stream: FirebaseAuth.instance.authStateChanges(),
//        builder: (context, snapshot) {
//          if (snapshot.hasData) {
//            return const HomeScreen();
//          } else {
//            return const LoginScreen();
//          }
//        },
//      ),
//    );
//  }
//}

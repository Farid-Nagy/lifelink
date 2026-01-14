import 'package:flutter/material.dart';
import 'package:lifelink/screen/login_screen.dart';
import 'package:lifelink/screen/signup_screen.dart';
import 'package:lifelink/screen/home_screen.dart';
import 'package:lifelink/screen/Pay_Now.dart';
import 'package:lifelink/screen/invoice_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
      routes: {
        "signupScreen": (context) => const SignupScreen(),
        "loginScreen": (context) => const LoginScreen(),
        "homeScreen": (context) => const HomeScreen(),
        "payNow": (context) => const PayNow(),
        "invoicePage": (context) => const InvoicePage(amount: 0, method: ''),
      },
    );
  }
}

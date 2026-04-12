import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifelink/internet_service.dart';
import 'package:lifelink/network_wrapper.dart';
import 'package:lifelink/screen/home_screen.dart';
import 'package:lifelink/screen/admin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _messageVisible = false;
  bool _isLoading = false;

  void showMessage(String text, {Color color = Colors.red}) {
    if (!mounted || _messageVisible) return;

    _messageVisible = true;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: Text(text),
            backgroundColor: color,
            duration: const Duration(seconds: 2),
          ),
        )
        .closed
        .then((_) {
      if (mounted) {
        setState(() {
          _messageVisible = false;
        });
      }
    });
  }

  Future<void> signIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      bool hasInternet = await InternetService.hasInternet();
      if (!mounted) return;

      if (!hasInternet) {
        showMessage("❌ No Internet Connection");
        setState(() => _isLoading = false);
        return;
      }

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (!mounted) return;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .get();

      if (!mounted) return;

      String role = userDoc["role"] ?? "user";

      setState(() {
        _isLoading = false;
      });

      if (role == "admin") {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const NetworkWrapper(child: AdminPage()),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const NetworkWrapper(child: HomeScreen()),
          ),
        );
      }
    } on FirebaseAuthException {
      if (mounted) {
        setState(() => _isLoading = false);
        showMessage("Incorrect login credentials");
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        showMessage("An error occurred. Please try again.");
      }
    }
  }

  Future<void> handleLogin() async {
    if (!mounted) return;

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      showMessage("Please fill in all fields");
      return;
    }

    if (_isLoading) return;

    await signIn();
  }

  void openSignupScreen() {
    if (mounted) {
      Navigator.of(context).pushNamed("signupScreen");
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkWrapper(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF00A7B3),
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            "LifeLink",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Cairo",
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset("images/logo.png", width: 250, height: 250),
                  const Text(
                    "LIFE LINK",
                    style: TextStyle(
                      fontFamily: "Cairo",
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00A7B3),
                    ),
                  ),
                  const Text(
                    "welcome back! Please \n login to your account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFF00A7B3),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Email field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _emailController,
                          enabled: !_isLoading,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Password field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          enabled: !_isLoading,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Sign in button بدون تأثير loading
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: _isLoading ? null : handleLogin,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00A7B3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text(
                            "login",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Signup row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF00A7B3),
                        ),
                      ),
                      GestureDetector(
                        onTap: _isLoading ? null : openSignupScreen,
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
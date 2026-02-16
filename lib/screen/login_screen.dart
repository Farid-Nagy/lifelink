import 'package:flutter/material.dart';
//import 'package:lifelink/screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    print("email: ${_emailController.text}");
    print("password: ${_passwordController.text}");
    //    await FirebaseAuth.instance.signInWithEmailAndPassword(
    //    email: _emailController.text.trim(),
    //  password: _passwordController.text.trim(),
    //);
    if (_emailController.text.contains('admin')) {
      openAdmin();
    } else if (_emailController.text.contains('homeScreen')) {
      openHomeScreen();
    }
  }

  void openAdmin() {
    Navigator.of(context).pushNamed("admin");
  }

  void openHomeScreen() {
    Navigator.of(context).pushNamed("homeScreen");
  }

  void openSignupScreen() {
    Navigator.of(context).pushNamed("signupScreen");
  }

  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            fontSize: 30.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,

              //image
              children: [
                Image.asset("images/logo.png", width: 250.0, height: 250.0),
                //Title
                Text(
                  "LIFE LINK",
                  style: TextStyle(
                    fontFamily: "Cairo",
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF00A7B3),
                  ),
                ),
                //Subtitle
                Text(
                  "welcome back! Please \n login to your account",
                  style: TextStyle(
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: const Color(0xFF00A7B3),
                  ),
                ),
                SizedBox(height: 20.0),
                //TextField Email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                //TextField Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                        ),
                      ),
                    ),
                  ),
                ),
                //Login Button
                SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: openHomeScreen,
                    // () {
                    //   if (_emailController.text.isEmpty ||
                    //       _passwordController.text.isEmpty) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(content: Text("Please fill in all fields")),
                    //     );
                    //   } else {
                    //     HomeScreen();
                    //   }
                    // },
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A7B3),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                //Signup Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: const Color(0xFF00A7B3),
                      ),
                    ),
                    GestureDetector(
                      onTap: openSignupScreen,
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

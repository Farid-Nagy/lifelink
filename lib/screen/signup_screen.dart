import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _usernameController = TextEditingController();
  final _nationalIdController = TextEditingController();
  // final _ageController = TextEditingController();
  //final _typeController = TextEditingController();
  //final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signUp() async {
    if (_usernameController.text.isEmpty ||
        _nationalIdController.text.isEmpty ||
        // _ageController.text.isEmpty ||
        // _typeController.text.isEmpty ||
        // _addressController.text.isEmpty ||
        _phoneNumberController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      print("Please fill in all fields");
      return;
    }
    print("username: ${_usernameController.text}");
    print("national ID: ${_nationalIdController.text}");
    //  print("age: ${_ageController.text}");
    // print("type: ${_typeController.text}");
    //print("address: ${_addressController.text}");
    print("phone number: ${_phoneNumberController.text}");
    print("email: ${_emailController.text}");
    print("password: ${_passwordController.text}");
    //    await FirebaseAuth.instance.signInWithEmailAndPassword(
    //    email: _emailController.text.trim(),
    //  password: _passwordController.text.trim(),
    //);
  }

  void openSignupScreen() {
    Navigator.of(context).pushNamed("signupScreen");
  }

  @override
  void dispose() {
    super.dispose();
    // TODO: impleme nt dispose
    _usernameController.dispose();
    _nationalIdController.dispose();
    //    _ageController.dispose();
    //  _typeController.dispose();
    //_addressController.dispose();
    _phoneNumberController.dispose();
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
                Image.asset("images/logo.png", width: 200.0, height: 200.0),
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
                  "           welcome! \n Here you can Sign Up ",
                  style: TextStyle(
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: const Color(0xFF00A7B3),
                  ),
                ),
                SizedBox(height: 20.0),
                //text field username
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
                        controller: _usernameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "UserName",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                //text field National ID
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
                        controller: _nationalIdController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "National ID",
                        ),
                      ),
                    ),
                  ),
                ),
                //SizedBox(height: 10.0),
                //text field Age
                //   Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //  child: Container(
                //   decoration: BoxDecoration(
                //    color: Colors.grey[200],
                //   borderRadius: BorderRadius.circular(15.0),
                //),
                //child: Padding(
                // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                //child: TextField(
                // controller: _ageController,
                //decoration: InputDecoration(
                // border: InputBorder.none,
                //hintText: "Age",
                // ),
                //     ),
                // ),
                // ),
                // ),
                //SizedBox(height: 10.0),
                //text field Type
                //Padding(
                //padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //child: Container(
                //decoration: BoxDecoration(
                // color: Colors.grey[200],
                //borderRadius: BorderRadius.circular(15.0),
                //),
                //child: Padding(
                //padding: const EdgeInsets.symmetric(horizontal: 20.0),
                //child: TextField(
                //controller: _typeController,
                //decoration: InputDecoration(
                //border: InputBorder.none,
                //hintText: "Type",
                //),
                //),
                //),
                // ),
                //),
                //SizedBox(height: 10.0),
                //text field Patient's address
                //Padding(
                //padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //child: Container(
                //decoration: BoxDecoration(
                //color: Colors.grey[200],
                //borderRadius: BorderRadius.circular(15.0),
                //),
                //child: Padding(
                //padding: const EdgeInsets.symmetric(horizontal: 20.0),
                //child: TextField(
                //controller: _addressController,
                //decoration: InputDecoration(
                //border: InputBorder.none,
                //hintText: "Patient's address",
                //),
                //),
                //),
                //),
                //),
                SizedBox(height: 10.0),
                //text field phone number
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
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone number",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
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
                        keyboardType: TextInputType.emailAddress,
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
                    onTap: () {
                      if (_usernameController.text.isEmpty ||
                          _nationalIdController.text.isEmpty ||
                          // _ageController.text.isEmpty ||
                          // _typeController.text.isEmpty ||
                          // _addressController.text.isEmpty ||
                          _phoneNumberController.text.isEmpty ||
                          _emailController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please fill in all fields")),
                        );
                      } else {
                        signUp();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A7B3),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Text(
                          "Sign In",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

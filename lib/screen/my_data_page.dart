import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifelink/screen/login_screen.dart';
//.
class MyDataScreen extends StatefulWidget {
  const MyDataScreen({super.key});
//.
  @override
  State<MyDataScreen> createState() => _MyDataScreenState();
}
class _MyDataScreenState extends State<MyDataScreen> {
String? name;
  String? nationalId;
  String? phone;
  String? email;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }
 bool isLoading = true;
 Future<void> fetchUserData() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    setState(() {
      if (doc.exists) {
        name = doc['username'];
        nationalId = doc['nationalid'];
        phone = doc['phone'];
        email = user.email;
      }
      isLoading = false;
    });
  } else {
    setState(() {
      isLoading = false;
    });
  }
}
//.
  @override//.
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      
      appBar: AppBar(
        backgroundColor: const Color(0xFF00A7B3),
        centerTitle: true,
        title: const Text(
          "My Data",
          style: TextStyle(
            fontFamily: "Cairo",
            fontSize: 29,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      //.
      body: isLoading
    ? const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF00A7B3),
        ),
      )
      
       :Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          
          child: Column(
            children: [
              const CircleAvatar(
                radius: 45,
                backgroundColor: Color(0xffE6E8EC),
                child: Icon(Icons.person, size: 50, color: Colors.grey),
              ),

              const SizedBox(height: 25),

              buildDataItem("Name", name),
              buildDataItem("National ID", nationalId),
              buildDataItem("Phone Number", phone),
              buildDataItem("Email Address", email),
              
              const Spacer(),
InkWell(
  onTap: () async {
    await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushReplacement(
  MaterialPageRoute(builder: (context) => LoginScreen()),
    );
    },
              //.
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.logout, color: Colors.red, size: 26),
                ],
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
//.
  Widget buildDataItem(String title, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),

        const SizedBox(height: 6),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xffF1F2F6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            value?.isNotEmpty == true ? value! : "--",
            style: const TextStyle(fontSize: 16),
          ),
        ),

        const SizedBox(height: 18),
      ],
    );
  }
}

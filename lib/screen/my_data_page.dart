import 'package:flutter/material.dart';

class MyDataScreen extends StatelessWidget {
  const MyDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? name;
    String? nationalId;
    String? phone;
    String? email;

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

      body: Padding(
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

              const Row(
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
            ],
          ),
        ),
      ),
    );
  }

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

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
        title: const Text("My Data"),
        centerTitle: true,
        backgroundColor: const Color(0xffF5F6FA),
        elevation: 0,
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

              buildDataItem("الاسم", name),
              buildDataItem("الرقم القومي", nationalId),
              buildDataItem("رقم الهاتف", phone),
              buildDataItem("البريد الإلكتروني", email),

              const Spacer(),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: 8),
                  Text(
                    "تسجيل الخروج",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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

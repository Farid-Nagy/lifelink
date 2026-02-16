import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:lifelink/screen/blood_type_page.dart';
import 'package:lifelink/screen/my_data_page.dart';
import 'package:lifelink/screen/about_page.dart';
import 'package:lifelink/screen/delivery_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 1;

  final List<Widget> pages = const [
    MyDataScreen(), // الشمال
    HomeContent(), // النص (Home)
    AboutPage(), // اليمين
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: selectedIndex == 1
          ? AppBar(
              backgroundColor: const Color(0xFF00A7B3),
              centerTitle: true,
              title: const Text(
                "Home",
                style: TextStyle(
                  fontFamily: "Cairo",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          : null,
      body: pages[selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(0xffF5F6FA),
        color: const Color(0xFF00A7B3),
        animationDuration: const Duration(milliseconds: 300),
        index: selectedIndex,
        items: const [
          Icon(Icons.person, size: 30, color: Colors.white),
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.info_outline, size: 30, color: Colors.white),
        ],
        onTap: (index) => setState(() => selectedIndex = index),
      ),
    );
  }
}

/// محتوى الصفحة الرئيسية
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: topCard(
                  context,
                  Icons.local_shipping,
                  "Delivery",
                  const DeliveryPage(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: topCard(
                  context,
                  Icons.bloodtype,
                  "Blood Bags Booking",
                  const BloodTypePage(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xff1FA5A9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                "Who Donates to Whom?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: const [
                BloodRow("O-", "Donates to everyone", "Receives from O-"),
                BloodRow(
                  "O+",
                  "Donates to O+, A+, B+, AB+",
                  "Receives from O+, O-",
                ),
                BloodRow(
                  "A-",
                  "Donates to A-, A+, AB-, AB+",
                  "Receives from A-, O-",
                ),
                BloodRow(
                  "A+",
                  "Donates to A+, AB+",
                  "Receives from A+, A-, O-",
                ),
                BloodRow(
                  "B-",
                  "Donates to B-, B+, AB-, AB+",
                  "Receives from B-, O-",
                ),
                BloodRow(
                  "B+",
                  "Donates to B+, AB+",
                  "Receives from B+, B-, O-",
                ),
                BloodRow(
                  "AB-",
                  "Donates to AB-, AB+",
                  "Receives from everyone",
                ),
                BloodRow("AB+", "Donates to AB+ only", "Universal receiver"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget topCard(
    BuildContext context,
    IconData icon,
    String title,
    Widget? navigateTo,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: navigateTo == null
          ? null
          : () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => navigateTo),
            ),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xff27B4B8), Color(0xff1FA5A9)],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withOpacity(.2),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 34),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BloodRow extends StatelessWidget {
  final String type;
  final String donate;
  final String receive;

  const BloodRow(this.type, this.donate, this.receive, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              color: Color(0xff1FA5A9),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                type,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  donate,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(receive, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

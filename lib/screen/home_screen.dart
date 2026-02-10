import 'package:flutter/material.dart';
import 'package:lifelink/screen/blood_type_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "الرئيسية",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Text("Home", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            /// الكروت اللي فوق
            Row(
              children: [
                Expanded(
                  child: topCard(context, Icons.local_shipping, "توصيل", null),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: topCard(
                    context,
                    Icons.bloodtype,
                    "حجز أكياس دم",
                    const BloodTypePage(), // ده اللي هيفتح لما تدوسي على المربع
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// عنوان الجدول
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xff1FA5A9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  "من يتبرع لمن؟",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// الليست
            Expanded(
              child: ListView(
                children: const [
                  BloodRow("O-", "يتبرع للجميع", "يستقبل من O-"),
                  BloodRow(
                    "O+",
                    "يتبرع لـ O+, A+, B+, AB+",
                    "يستقبل من O+, O-",
                  ),
                  BloodRow(
                    "A-",
                    "يتبرع لـ A-, A+, AB-, AB+",
                    "يستقبل من A-, O-",
                  ),
                  BloodRow("A+", "يتبرع لـ A+, AB+", "يستقبل من A+, A-, O-"),
                  BloodRow(
                    "B-",
                    "يتبرع لـ B-, B+, AB-, AB+",
                    "يستقبل من B-, O-",
                  ),
                  BloodRow("B+", "يتبرع لـ B+, AB+", "يتبرع من B+, B-, O-"),
                  BloodRow("AB-", "يتبرع لـ AB-, AB+", "يستقبل من الجميع"),
                  BloodRow("AB+", "يتبرع لـ AB+ فقط", "المستقبل العام"),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xff1FA5A9),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
        ],
      ),
    );
  }

  /// الكارد اللي فوق (لينك)
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
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => navigateTo),
              );
            },
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

/// الصف بتاع فصيلة الدم
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
          /// الدائرة
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

          /// النصوص
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

import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final TextEditingController leaderName = TextEditingController();
  final TextEditingController leaderRole = TextEditingController();

  @override
  void dispose() {
    leaderName.dispose();
    leaderRole.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // ===== AppBar =====
      appBar: AppBar(
        backgroundColor: const Color(0xFF00A7B3),
        centerTitle: true,
        title: const Text(
          "About LifeLink",
          style: TextStyle(
            fontFamily: "Cairo",
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      // ===== Body =====
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ===== Logo =====
          Image.asset("images/logo.png", width: 200, height: 200),

          const SizedBox(height: 10),

          // ===== App Title (تم تغيير الخط إلى Amiri) =====
          const Text(
            "LIFE LINK",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Amiri", // ← الخط الأميري هنا
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00A7B3),
              letterSpacing: 2,
            ),
          ),

          const SizedBox(height: 25),

          // ===== Project Description =====
          const Text(
            "جاءت فكرة تطبيق LifeLink استجابةً لمشكلة مجتمعية هامة "
            "تتمثل في صعوبة إدارة وتوزيع أكياس الدم بين المستشفيات.\n\n"
            "تعاني بعض المستشفيات من نقص حاد في فصائل معينة، "
            "بينما تمتلك مستشفيات أخرى فائضًا غير مستغل.\n\n"
            "لذلك قمنا بتصميم نظام ذكي يهدف إلى تنظيم، متابعة، "
            "وإدارة مخزون أكياس الدم بشكل دقيق وفعّال، "
            "مما يضمن سرعة الاستجابة وتقليل الهدر وتحقيق التكامل بين الجهات الطبية.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Amiri",
              fontSize: 18,
              height: 1.6,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 40),

          // ===== Leader Card =====
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(Icons.star, color: Color(0xFF00A7B3), size: 30),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Team Leader",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00A7B3),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Name: كريم علاء الدين محمد بكري",
                        style: TextStyle(fontFamily: "Cairo", fontSize: 16),
                      ),
                      Text(
                        "Role: Flutter Developer & tester &\n Project Manager",
                        style: TextStyle(fontFamily: "Cairo", fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),

          // ===== Members Cards =====
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(
                    Icons.person_outline,
                    color: Color(0xFF00A7B3),
                    size: 30,
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Member 1",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00A7B3),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Name: فريد ناجي فريد كامل ميخائيل",
                        style: TextStyle(fontFamily: "Cairo", fontSize: 16),
                      ),
                      Text(
                        "Role: Flutter Developer",
                        style: TextStyle(fontFamily: "Cairo", fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(
                    Icons.person_outline,
                    color: Color(0xFF00A7B3),
                    size: 30,
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Member 2",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00A7B3),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Name: محمود ياسر محمود سيد",
                        style: TextStyle(fontFamily: "Cairo", fontSize: 16),
                      ),
                      Text(
                        "Role: Backend Developer",
                        style: TextStyle(fontFamily: "Cairo", fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(
                    Icons.person_outline,
                    color: Color(0xFF00A7B3),
                    size: 30,
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Member 3",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00A7B3),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Name: اسماء عمرو محمد طه",
                        style: TextStyle(fontFamily: "Cairo", fontSize: 16),
                      ),
                      Text(
                        "Role: Backend Developer",
                        style: TextStyle(fontFamily: "Cairo", fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(
                    Icons.person_outline,
                    color: Color(0xFF00A7B3),
                    size: 30,
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Member 4",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00A7B3),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Name: رفقة كمال رياض",
                        style: TextStyle(fontFamily: "Cairo", fontSize: 16),
                      ),
                      Text(
                        "Role: Flutter Developer",
                        style: TextStyle(fontFamily: "Cairo", fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(
                    Icons.person_outline,
                    color: Color(0xFF00A7B3),
                    size: 30,
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Member 5",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00A7B3),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Name: منتصر كرم ابو النجا سليمان",
                        style: TextStyle(fontFamily: "Cairo", fontSize: 16),
                      ),
                      Text(
                        "Role: Backend Developer",
                        style: TextStyle(fontFamily: "Cairo", fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(
                    Icons.person_outline,
                    color: Color(0xFF00A7B3),
                    size: 30,
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Member 6",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00A7B3),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Name: سهيله حسن علي حسن",
                        style: TextStyle(fontFamily: "Cairo", fontSize: 16),
                      ),
                      Text(
                        "Role: Ui/UX Designer",
                        style: TextStyle(fontFamily: "Cairo", fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(
                    Icons.person_outline,
                    color: Color(0xFF00A7B3),
                    size: 30,
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Member 7",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00A7B3),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Name: تقى هشام احمد حسن",
                        style: TextStyle(fontFamily: "Cairo", fontSize: 16),
                      ),
                      Text(
                        "Role: Text project book",
                        style: TextStyle(fontFamily: "Cairo", fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(
                    Icons.person_outline,
                    color: Color(0xFF00A7B3),
                    size: 30,
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Member 8",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00A7B3),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Name: سلمى محمود عرفان احمد",
                        style: TextStyle(fontFamily: "Cairo", fontSize: 16),
                      ),
                      Text(
                        "Role: Text project book",
                        style: TextStyle(fontFamily: "Cairo", fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(
                    Icons.person_outline,
                    color: Color(0xFF00A7B3),
                    size: 30,
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Member 9",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00A7B3),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Name: احمد سيد محمد عمار",
                        style: TextStyle(fontFamily: "Cairo", fontSize: 16),
                      ),
                      Text(
                        "Role: Text project book",
                        style: TextStyle(fontFamily: "Cairo", fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

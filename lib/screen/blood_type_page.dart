import 'package:flutter/material.dart';

class BloodTypePage extends StatefulWidget {
  const BloodTypePage({super.key});

  @override
  State<BloodTypePage> createState() => _BloodTypePageState();
}

class _BloodTypePageState extends State<BloodTypePage> {
  String? selectedBlood;
  String? selectedHospital;

  final List<String> bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  final Map<String, int> quantities = {
    'A+': 10,
    'A-': 4,
    'B+': 6,
    'B-': 2,
    'AB+': 3,
    'AB-': 1,
    'O+': 12,
    'O-': 5,
  };

  final Map<String, List<String>> hospitals = {
    'A+': ['Hospital A', 'Hospital B'],
    'A-': ['Hospital A'],
    'B+': ['Hospital C'],
    'B-': ['Hospital C'],
    'AB+': ['Hospital D'],
    'AB-': ['Hospital D'],
    'O+': ['Hospital A', 'Hospital C'],
    'O-': ['Hospital B'],
  };

  void openHomeScreen() {
    Navigator.of(context).pushNamed("homeScreen");
  }

  void payNow() {
    Navigator.of(context).pushNamed("payNow");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Pick your blood type',
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Cairo",
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF00A7B3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bloodTypes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final type = bloodTypes[index];
                final isSelected = selectedBlood == type;

                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedBlood = type;
                      selectedHospital = null;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF00A7B3)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF00A7B3)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          type,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Qty: ${quantities[type]}',
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? Colors.white70 : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              //تم اضافته
              value: selectedHospital,
              hint: const Text('Select hospital'),
              decoration: const InputDecoration(
                labelText: 'Hospital',
                border: OutlineInputBorder(),
              ),
              items: selectedBlood == null
                  ? []
                  : hospitals[selectedBlood]!
                        .map(
                          (h) => DropdownMenuItem<String>(
                            value: h,
                            child: Text(h),
                          ),
                        )
                        .toList(),
              onChanged: selectedBlood == null
                  ? null
                  : (value) {
                      setState(() {
                        selectedHospital = value;
                      });
                    },
            ),

            const Spacer(),

            SizedBox(
              child: GestureDetector(
                onTap: selectedBlood != null && selectedHospital != null
                    ? () {
                        payNow();
                      }
                    : null,
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00A7B3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: selectedBlood != null && selectedHospital != null
                        ? () {
                            payNow();
                          }
                        : null,
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

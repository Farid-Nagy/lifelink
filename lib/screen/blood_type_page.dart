import 'package:flutter/material.dart';
import 'Pay_Now.dart';

class BloodTypePage extends StatefulWidget {
  const BloodTypePage({super.key});

  @override
  State<BloodTypePage> createState() => _BloodTypePageState();
}

class _BloodTypePageState extends State<BloodTypePage> {
  String? selectedBlood;
  String? selectedHospital;

  int count = 1;
  DateTime? receiveDate;

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

  void pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() {
        receiveDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ باك جراوند أبيض
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Pick your blood type',
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Cairo",
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF00A7B3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 🔹 Grid Blood Types
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
                      borderRadius: BorderRadius.circular(14),
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

            /// 🔹 Hospital Dropdown (كيرف)
            DropdownButtonFormField<String>(
              value: selectedHospital,
              hint: const Text('Select hospital'),
              decoration: InputDecoration(
                labelText: 'Hospital',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              items: selectedBlood == null
                  ? []
                  : hospitals[selectedBlood]!
                        .map((h) => DropdownMenuItem(value: h, child: Text(h)))
                        .toList(),
              onChanged: selectedBlood == null
                  ? null
                  : (value) => setState(() => selectedHospital = value),
            ),

            const SizedBox(height: 16),

            /// 🔹 Counter
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: count > 1 ? () => setState(() => count--) : null,
                  icon: const Icon(Icons.remove),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Text('$count', style: const TextStyle(fontSize: 18)),
                ),
                IconButton(
                  onPressed: () => setState(() => count++),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// 🔹 Date Picker
            InkWell(
              onTap: pickDate,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                  receiveDate == null
                      ? 'Select receive date'
                      : 'Receive Date: ${receiveDate!.day}/${receiveDate!.month}/${receiveDate!.year}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),

            const Spacer(),

            /// 🔹 Next Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A7B3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed:
                    selectedBlood != null &&
                        selectedHospital != null &&
                        receiveDate != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PayNow(),
                          ),
                        );
                      }
                    : null,
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

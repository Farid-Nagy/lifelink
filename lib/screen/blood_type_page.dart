import 'package:flutter/material.dart';
import 'package:lifelink/screen/Pay_Now.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BloodTypePage extends StatefulWidget {
  const BloodTypePage({super.key});

  @override
  State<BloodTypePage> createState() => _BloodTypePageState();
}

class _BloodTypePageState extends State<BloodTypePage> {
  String? selectedBlood;
  String? selectedHospital;
  int count = 1;
  int availableQty = 0;
  DateTime? receiveDate;

  Map<String, Map<String, dynamic>> bloodData = {};
  
  // إضافة متغير لتخزين آخر البيانات المستلمة
  Map<String, Map<String, dynamic>>? lastBloodData;

  void pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) setState(() => receiveDate = date);
  }

  // دالة لتحديث البيانات والمتغيرات المرتبطة
  void updateBloodData(Map<String, Map<String, dynamic>> newData) {
    lastBloodData = newData;
    
    if (selectedBlood != null && selectedHospital != null) {
      // التحقق مما إذا كان المستشفى المختار لا يزال متاحاً
      if (!newData.containsKey(selectedBlood) ||
          !newData[selectedBlood]!.containsKey(selectedHospital) ||
          (newData[selectedBlood]![selectedHospital]! as int) <= 0) {
        
        // إعادة تعيين الاختيار إذا أصبح غير متاح
        setState(() {
          selectedHospital = null;
          count = 1;
          availableQty = 0;
        });
      } else {
        // تحديث الكمية المتاحة
        int newAvailableQty = newData[selectedBlood]![selectedHospital] as int;
        if (availableQty != newAvailableQty) {
          setState(() {
            availableQty = newAvailableQty;
            if (count > availableQty) count = availableQty;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF00A7B3);

    BoxDecoration boxDecoration({bool selected = false}) => BoxDecoration(
          color: selected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: primaryColor),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          "Pick your blood type",
          style: TextStyle(
            fontFamily: "Cairo",
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('blood_inventory').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            // بناء البيانات
            bloodData = {};
            for (var doc in snapshot.data!.docs) {
              bloodData[doc.id] = Map<String, dynamic>.from(doc['hospitals']);
            }

            // تحديث البيانات عند وصول بيانات جديدة
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (lastBloodData != bloodData) {
                updateBloodData(bloodData);
              }
            });

            return SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bloodData.keys.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final type = bloodData.keys.elementAt(index);
                      int totalQty = 0;
                      bloodData[type]!.forEach((key, value) {
                        totalQty += value as int;
                      });
                      final isSelected = selectedBlood == type;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedBlood = type;
                            selectedHospital = null;
                            count = 1;
                          });
                        },
                        child: Container(
                          decoration: boxDecoration(selected: isSelected),
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
                                'Qty: $totalQty',
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
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: boxDecoration(),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              key: ValueKey('${selectedBlood}_${bloodData.hashCode}'), // مفتاح ديناميكي لإجبار إعادة البناء
                              value: selectedHospital,
                              hint: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Text("Hospital"),
                              ),
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_drop_down),
                              dropdownColor: Colors.white,
                              elevation: 2,
                              style: const TextStyle(color: Colors.black87),
                              items: selectedBlood == null
                                  ? []
                                  : bloodData[selectedBlood]!.keys
                                      .where((h) =>
                                          (bloodData[selectedBlood]![h] as int) > 0)
                                      .map((h) => DropdownMenuItem(
                                            value: h,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 12),
                                              child: Text(h),
                                            ),
                                          ))
                                      .toList(),
                              onChanged: selectedBlood == null
                                  ? null
                                  : (value) {
                                      setState(() {
                                        selectedHospital = value;
                                        availableQty =
                                            bloodData[selectedBlood]![selectedHospital] as int;
                                        count = 1;
                                      });
                                    },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: boxDecoration(),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: count > 1 && selectedHospital != null
                                      ? () => setState(() => count--)
                                      : null,
                                  icon: const Icon(Icons.remove, color: primaryColor),
                                ),
                                Text(
                                  '$count',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: (selectedHospital != null &&
                                          availableQty > 0 &&
                                          count < availableQty)
                                      ? () => setState(() => count++)
                                      : null,
                                  icon: const Icon(Icons.add, color: primaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: pickDate,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: boxDecoration(),
                      child: Text(
                        receiveDate == null
                            ? 'Receive Date'
                            : 'Receive Date: ${receiveDate!.day}/${receiveDate!.month}/${receiveDate!.year}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        shadowColor: primaryColor.withOpacity(0.4),
                        elevation: 6,
                      ),
                      onPressed: selectedBlood != null &&
                              selectedHospital != null &&
                              receiveDate != null &&
                              availableQty > 0
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PayNow(
                                    bloodType: selectedBlood!,
                                    hospital: selectedHospital!,
                                    quantity: count,
                                    receiveDate: receiveDate!,
                                    orderType: "Pickup",
                                  ),
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
            );
          },
        ),
      ),
    );
  }
}

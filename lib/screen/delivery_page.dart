import 'package:flutter/material.dart';
import 'package:lifelink/screen/Pay_Now.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const Color primaryColor = Color(0xFF00A7B3);

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  String? selectedBlood;
  String? selectedHospital;
  int count = 1;
  int availableQty = 0;
  DateTime? receiveDate;

  final TextEditingController hospitalNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final double deliveryFee = 50.0;

  // تخزين آخر البيانات المستلمة
  Map<String, Map<String, dynamic>>? lastBloodData;

  Stream<Map<String, Map<String, dynamic>>> getBloodStream() {
    return FirebaseFirestore.instance
        .collection('blood_inventory')
        .snapshots()
        .map((snapshot) {
      Map<String, Map<String, dynamic>> tempData = {};
      for (var doc in snapshot.docs) {
        tempData[doc.id] =
            Map<String, dynamic>.from(doc['hospitals'] ?? {});
      }
      return tempData;
    });
  }

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
    
    if (selectedBlood != null) {
      final availableHospitals = newData[selectedBlood]!.entries
          .where((entry) {
            int val = (entry.value is int)
                ? entry.value as int
                : (entry.value as num).toInt();
            return val > 0;
          })
          .toList();

      // إذا المستشفى المختارة لم تعد موجودة أو كميتها صفر
      if (selectedHospital != null &&
          !availableHospitals.any((entry) => entry.key == selectedHospital)) {
        selectedHospital = null;
        count = 1;
        availableQty = 0;
      }

      // تحديث availableQty إذا هناك مستشفى مختارة
      if (selectedHospital != null) {
        availableQty = (newData[selectedBlood]![selectedHospital]! is int)
            ? newData[selectedBlood]![selectedHospital]! as int
            : (newData[selectedBlood]![selectedHospital]! as num).toInt();
        if (count > availableQty) count = availableQty;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool showDeliveryFee = addressController.text.isNotEmpty;

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
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          "Delivery Details",
          style: TextStyle(
            fontFamily: "Cairo",
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<Map<String, Map<String, dynamic>>>(
        stream: getBloodStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final bloodData = snapshot.data!;
          
          // تحديث البيانات عند وصول بيانات جديدة
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (lastBloodData != bloodData) {
              updateBloodData(bloodData);
            }
          });

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                /// BLOOD TYPES GRID
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: bloodData.keys.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final type = bloodData.keys.elementAt(index);

                    int totalQty = 0;
                    bloodData[type]!.forEach((key, value) {
                      int val = (value is int) ? value : (value as num).toInt();
                      totalQty += val;
                    });

                    final isSelected = selectedBlood == type;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedBlood = type;
                          selectedHospital = null;
                          availableQty = 0;
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
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Qty: $totalQty',
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected
                                    ? Colors.white70
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                /// HOSPITAL + COUNTER
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: boxDecoration(),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: DropdownButtonFormField<String>(
                          key: ValueKey('${selectedBlood}_${bloodData.hashCode}'), // مفتاح ديناميكي لإجبار إعادة البناء
                          value: selectedHospital,
                          hint: const Text('Hospital'),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          items: selectedBlood == null
                              ? <DropdownMenuItem<String>>[]
                              : bloodData[selectedBlood]!.entries
                                  .where((entry) {
                                    int val = (entry.value is int)
                                        ? entry.value as int
                                        : (entry.value as num).toInt();
                                    return val > 0;
                                  })
                                  .map((entry) => DropdownMenuItem<String>(
                                        value: entry.key,
                                        child: Text(entry.key),
                                      ))
                                  .toList(),
                          onChanged: selectedBlood == null
                              ? null
                              : (value) {
                                  setState(() {
                                    selectedHospital = value;
                                    availableQty = (bloodData[selectedBlood]![selectedHospital]! is int)
                                        ? bloodData[selectedBlood]![selectedHospital]! as int
                                        : (bloodData[selectedBlood]![selectedHospital]! as num).toInt();
                                    count = 1;
                                  });
                                },
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
                                onPressed: (count > 1 && selectedHospital != null)
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
                                onPressed: (selectedHospital != null && count < availableQty)
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

                /// Hospital Name
                Container(
                  decoration: boxDecoration(),
                  child: TextField(
                    controller: hospitalNameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      labelText: 'Hospital Name',
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                /// Address
                Container(
                  decoration: boxDecoration(),
                  child: TextField(
                    controller: addressController,
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      labelText: 'Delivery Address',
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// Date
                InkWell(
                  onTap: pickDate,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: boxDecoration(),
                    child: Text(
                      receiveDate == null
                          ? 'Select Delivery Date'
                          : 'Delivery Date: ${receiveDate!.day}/${receiveDate!.month}/${receiveDate!.year}',
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                if (showDeliveryFee)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: boxDecoration(),
                    child: Text(
                      'Delivery Fee: EGP $deliveryFee',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                const SizedBox(height: 20),

                /// NEXT BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: selectedBlood != null &&
                            selectedHospital != null &&
                            receiveDate != null &&
                            hospitalNameController.text.isNotEmpty &&
                            addressController.text.isNotEmpty
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PayNow(
                                  bloodType: selectedBlood!,
                                  hospital: hospitalNameController.text,
                                  quantity: count,
                                  receiveDate: receiveDate!,
                                  orderType: "Delivery",
                                  deliveryAddress: addressController.text,
                                  deliveryFee: deliveryFee,
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
    );
  }
}

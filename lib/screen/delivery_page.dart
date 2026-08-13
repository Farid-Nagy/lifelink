import 'package:flutter/material.dart';
import 'package:lifelink/screen/Pay_Now.dart';

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
  DateTime? receiveDate;

  final TextEditingController hospitalNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final double deliveryFee = 50.0;

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
    if (date != null) setState(() => receiveDate = date);
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
      resizeToAvoidBottomInset: true,
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// BLOOD GRID
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

            /// HOSPITAL + QTY
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: boxDecoration(),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: DropdownButtonFormField<String>(
                      value: selectedHospital,
                      hint: const Text('Hospital'),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      items: selectedBlood == null
                          ? []
                          : hospitals[selectedBlood]!
                                .map(
                                  (h) => DropdownMenuItem(
                                    value: h,
                                    child: Text(h),
                                  ),
                                )
                                .toList(),
                      onChanged: selectedBlood == null
                          ? null
                          : (value) => setState(() => selectedHospital = value),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: boxDecoration(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: count > 1
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
                          onPressed: () => setState(() => count++),
                          icon: const Icon(Icons.add, color: primaryColor),
                        ),
                      ],
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

            /// Delivery Address
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

            /// DATE
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
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Delivery Fee
            if (showDeliveryFee)
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
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
                  shadowColor: primaryColor.withOpacity(0.4),
                  elevation: 6,
                ),
                onPressed:
                    selectedBlood != null &&
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

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'pay_now.dart';

class InvoicePage extends StatelessWidget {
  final double amount;
  final String method;
  final String orderType;
  final String bloodType;
  final String hospital;
  final int quantity;
  final DateTime receiveDate;

  const InvoicePage({
    super.key,
    required this.amount,
    required this.method,
    required this.orderType,
    required this.bloodType,
    required this.hospital,
    required this.quantity,
    required this.receiveDate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    final invoiceNumber = "#INV-${DateTime.now().millisecondsSinceEpoch}";
    final transactionNumber =
        "OPR-${DateTime.now().second}${DateTime.now().millisecond}";
    final date = "${receiveDate.day}/${receiveDate.month}/${receiveDate.year}";
    final time = "${DateTime.now().hour}:${DateTime.now().minute}";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text("Invoice"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(Icons.receipt_long, size: 50, color: primary),
                  const SizedBox(height: 12),
                  Text(
                    "Payment Successful",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Thank you for using Lifelink",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // تفاصيل الفاتورة
            _invoiceItem("Invoice Number", invoiceNumber),
            _invoiceItem("Transaction Number", transactionNumber),
            _invoiceItem("Date", date),
            _invoiceItem("Time", time),
            _invoiceItem("Order Type", orderType),
            _invoiceItem("Payment Method", method),
            _invoiceItem("Blood Type", bloodType),
            _invoiceItem("Hospital", hospital),
            _invoiceItem("Quantity", quantity.toString()),
            _invoiceItem("Amount Paid", "${amount.toStringAsFixed(2)} EGP"),
            _invoiceItem("Status", "Successful", highlight: true),

            const SizedBox(height: 30),

            // زر الرجوع
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: primary, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black38,
                ),
                child: Text(
                  "Back",
                  style: TextStyle(
                    color: primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // زر PDF
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  // ربط وظيفة PDF لاحقًا
                },
                icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                label: const Text(
                  "Download PDF",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _invoiceItem(String title, String value, {bool highlight = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDDE2E5)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: highlight ? Colors.green : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

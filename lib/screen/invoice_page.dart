import 'package:flutter/material.dart';
//import 'package:share_plus/share_plus.dart'; // لإضافة ميزة المشاركة
import 'home_screen.dart';

class InvoicePage extends StatelessWidget {
  final double amount;
  final String method;
  final String orderType;

  const InvoicePage({
    super.key,
    required this.amount,
    required this.method,
    required this.orderType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final primary = theme.colorScheme.primary;

    // توليد رقم الفاتورة ووقت العملية
    final invoiceNumber = "#INV-${DateTime.now().millisecondsSinceEpoch}";
    final transactionNumber =
        "OPR-${DateTime.now().second}${DateTime.now().millisecond}";
    final date =
        "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
    final time = "${DateTime.now().hour}:${DateTime.now().minute}";

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, // إزالة السهم
        leading: null,
        title: Text("Invoice", style: text.titleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black87),
            onPressed: () {
              final invoiceText =
                  """
Invoice Number: $invoiceNumber
Transaction Number: $transactionNumber
Date: $date
Time: $time
Order Type: $orderType
Payment Method: $method
Amount Paid: ${amount.toStringAsFixed(2)} EGP
Status: Successful
""";
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ---------- Header ----------
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(Icons.receipt_long, size: 50, color: primary),
                  const SizedBox(height: 10),
                  Text(
                    "Payment Successful",
                    style: text.titleLarge!.copyWith(color: primary),
                  ),
                  const SizedBox(height: 5),
                  Text("Thank you for using Lifelink", style: text.bodyMedium),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ---------- Invoice Details ----------
            _invoiceItem("Invoice Number", invoiceNumber),
            _invoiceItem("Transaction Number", transactionNumber),
            _invoiceItem("Date", date),
            _invoiceItem("Time", time),
            _invoiceItem("Order Type", orderType),
            _invoiceItem("Payment Method", method),
            _invoiceItem("Amount Paid", "${amount.toStringAsFixed(2)} EGP"),
            _invoiceItem("Status", "Successful", highlight: true),

            const SizedBox(height: 30),

            // ---------- Download PDF ----------
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  // هنا يمكنك إضافة وظيفة إنشاء PDF إذا أردت
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                label: const Text(
                  "Download Invoice PDF",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ---------- Back to Home ----------
            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (route) => false,
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  "Back to Home",
                  style: TextStyle(color: primary, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  // ---------- Invoice Item ----------
  Widget _invoiceItem(String title, String value, {bool highlight = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDDE2E5)),
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
              color: highlight ? Colors.green : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class InvoicePage extends StatelessWidget {
  final double amount;
  final String method;

  const InvoicePage({super.key, required this.amount, required this.method});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text("فاتورة الدفع"), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // -----------------------------------
              // رأس الفاتورة
              // -----------------------------------
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
                      "تم الدفع بنجاح",
                      style: textTheme.titleLarge!.copyWith(color: primary),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "شكراً لك على استخدامك بنك الدم",
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // -----------------------------------
              // بيانات الفاتورة
              // -----------------------------------
              _invoiceItem(
                "رقم الفاتورة",
                "#INV-${DateTime.now().millisecondsSinceEpoch}",
              ),
              _invoiceItem(
                "تاريخ العملية",
                "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
              ),
              _invoiceItem(
                "الوقت",
                "${DateTime.now().hour}:${DateTime.now().minute}",
              ),
              _invoiceItem("نوع الفصيلة", "AB+"),
              _invoiceItem("الغرض", "شراء كيس دم"),
              _invoiceItem("طريقة الدفع", method),
              _invoiceItem("المبلغ المدفوع", "$amount جنيه"),
              _invoiceItem("حالة الدفع", "ناجح", highlight: true),
              _invoiceItem(
                "رقم العملية",
                "OPR-${DateTime.now().second}${DateTime.now().millisecond}",
              ),

              const SizedBox(height: 30),

              // -----------------------------------
              // تنزيل الفاتورة
              // -----------------------------------
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                  label: const Text(
                    "تحميل الفاتورة PDF",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -----------------------------------
  // عنصر من عناصر الفاتورة
  // -----------------------------------
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

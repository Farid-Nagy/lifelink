import 'package:flutter/material.dart';
import 'invoice_page.dart';

const Color primaryColor = Color(0xFF00A7B3);

class PayNow extends StatelessWidget {
  final String bloodType;
  final String hospital;
  final int quantity;
  final DateTime receiveDate;

  const PayNow({
    super.key,
    required this.bloodType,
    required this.hospital,
    required this.quantity,
    required this.receiveDate,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: 'Tajawal',
        scaffoldBackgroundColor: const Color(0xFFF7F7F8),
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
      ),
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: PaymentScreen(
          bloodType: bloodType,
          hospital: hospital,
          quantity: quantity,
          receiveDate: receiveDate,
        ),
      ),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  final String bloodType;
  final String hospital;
  final int quantity;
  final DateTime receiveDate;

  const PaymentScreen({
    super.key,
    required this.bloodType,
    required this.hospital,
    required this.quantity,
    required this.receiveDate,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

enum PaymentMethod { telda, visa, mastercard }

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethod _selected = PaymentMethod.telda;

  final double _amountPerBag = 200.0;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _cardNumber = TextEditingController();
  final TextEditingController _expiry = TextEditingController();
  final TextEditingController _cvv = TextEditingController();

  double get totalAmount => _amountPerBag * widget.quantity;

  void _formatCardNumber(String value) {
    value = value.replaceAll(" ", "");
    String newValue = "";
    for (int i = 0; i < value.length; i++) {
      newValue += value[i];
      if ((i + 1) % 4 == 0 && i != value.length - 1) newValue += " ";
    }
    _cardNumber.value = TextEditingValue(
      text: newValue,
      selection: TextSelection.collapsed(offset: newValue.length),
    );
  }

  void _formatExpiry(String value) {
    value = value.replaceAll("/", "");
    if (value.length >= 3) {
      value = value.substring(0, 2) + "/" + value.substring(2);
    }
    _expiry.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
  }

  void _clearForm() {
    _cardNumber.clear();
    _expiry.clear();
    _cvv.clear();
  }

  @override
  void dispose() {
    _clearForm();
    _cardNumber.dispose();
    _expiry.dispose();
    _cvv.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(Icons.bloodtype, color: primaryColor),
            ),
            const SizedBox(width: 10),
            Text(
              "Lifelink",
              style: text.titleLarge!.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Payment", style: text.displayMedium),
            const SizedBox(height: 15),
            _summaryCard(text),
            const SizedBox(height: 25),

            Text("Payment Method", style: text.titleMedium),
            const SizedBox(height: 10),

            _paymentTile(
              title: "Telda",
              subtitle: "Fast & secure",
              icon: Image.asset("images/01.png", width: 55),
              value: PaymentMethod.telda,
            ),
            const SizedBox(height: 10),

            _paymentTile(
              title: "VISA",
              subtitle: "Credit / Debit Card",
              icon: Image.asset("images/03.png", width: 55),
              value: PaymentMethod.visa,
            ),
            const SizedBox(height: 10),

            _paymentTile(
              title: "Mastercard",
              subtitle: "Credit / Debit Card",
              icon: Image.asset("images/02.png", width: 55),
              value: PaymentMethod.mastercard,
            ),

            const SizedBox(height: 25),

            /// 🔥 التعديل هنا (Telda أصبح يستخدم نفس الكارد فورم)
            Form(key: _formKey, child: _cardForm(text)),

            const SizedBox(height: 25),
            _payBtn(),
            const SizedBox(height: 20),

            Center(
              child: Text("All rights reserved 2025", style: text.bodySmall),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(TextTheme text) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE7C6C6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Transaction Summary",
            style: text.titleMedium!.copyWith(color: primaryColor),
          ),
          const SizedBox(height: 10),
          _row("Blood Type", widget.bloodType),
          _row("Hospital", widget.hospital),
          _row("Quantity", "${widget.quantity} bag(s)"),
          _row(
            "Receive Date",
            "${widget.receiveDate.day}/${widget.receiveDate.month}/${widget.receiveDate.year}",
          ),
          _row("Amount", "${totalAmount.toStringAsFixed(0)} EGP"),
        ],
      ),
    );
  }

  Widget _row(String left, String right) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left),
          Text(right, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _paymentTile({
    required String title,
    required String subtitle,
    required Widget icon,
    required PaymentMethod value,
  }) {
    final selected = _selected == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selected = value;
          _clearForm();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 6)],
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: selected ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: selected ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Radio(
              value: value,
              groupValue: _selected,
              activeColor: Colors.white,
              onChanged: (v) {
                setState(() {
                  _selected = v!;
                  _clearForm();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardForm(TextTheme text) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Card Details",
            style: text.titleMedium!.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 15),

          TextFormField(
            controller: _cardNumber,
            keyboardType: TextInputType.number,
            maxLength: 19,
            onChanged: _formatCardNumber,
            validator: (value) =>
                value == null || value.isEmpty ? "Enter card number" : null,
            decoration: _input("Card Number"),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _expiry,
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  onChanged: _formatExpiry,
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter expiry" : null,
                  decoration: _input("Expiry MM/YY"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _cvv,
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  obscureText: true,
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter CVV" : null,
                  decoration: _input("CVV"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _input(String hint) => InputDecoration(
    hintText: hint,
    counterText: "",
    filled: true,
    fillColor: const Color(0xFFF8F8F8),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  );

  Widget _payBtn() {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: _onPayPressed,
        child: const Text(
          "Pay Now",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  void _onPayPressed() {
    if (!_formKey.currentState!.validate()) return;

    final method = _selected == PaymentMethod.telda
        ? "Telda"
        : _selected == PaymentMethod.visa
        ? "VISA"
        : "Mastercard";

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => InvoicePage(
          amount: totalAmount,
          method: method,
          orderType: "${widget.bloodType} Blood Bag",
          bloodType: widget.bloodType,
          hospital: widget.hospital,
          quantity: widget.quantity,
          receiveDate: widget.receiveDate,
        ),
      ),
    );
  }
}

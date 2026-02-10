import 'package:flutter/material.dart';
import 'invoice_page.dart';

class PayNow extends StatelessWidget {
  const PayNow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: 'Tajawal',
        scaffoldBackgroundColor: const Color(0xFFF7F7F8),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(fontSize: 18),
          bodySmall: TextStyle(fontSize: 16),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00A7B3)),
      ),
      home: const Directionality(
        textDirection: TextDirection.ltr,
        child: PaymentScreen(),
      ),
    );
  }
}

// ======================================================

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

enum PaymentMethod { telda, visa, mastercard }

enum OrderType { reservation, urgent }

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethod _selected = PaymentMethod.telda;
  OrderType _orderType = OrderType.reservation;

  final double _amount = 200.0;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  // ---------------- Formatting ----------------
  void _formatCardNumber(String value) {
    value = value.replaceAll(" ", "");
    String newValue = "";
    for (int i = 0; i < value.length; i++) {
      newValue += value[i];
      if ((i + 1) % 4 == 0 && i != value.length - 1) newValue += " ";
    }
    _cardNumberController.value = TextEditingValue(
      text: newValue,
      selection: TextSelection.collapsed(offset: newValue.length),
    );
  }

  void _formatExpiry(String value) {
    value = value.replaceAll("/", "");
    if (value.length >= 3)
      value = value.substring(0, 2) + "/" + value.substring(2);
    _expiryController.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
  }

  void _clearCardData() {
    _cardNumberController.clear();
    _expiryController.clear();
    _cvvController.clear();
  }

  @override
  void dispose() {
    _clearCardData();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  // ================= BUILD ======================
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final primary = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Icon(Icons.bloodtype, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Text("Lifelink", style: text.titleLarge),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Payment", style: text.displayMedium),
            const SizedBox(height: 12),
            _summaryCard(text, primary),
            const SizedBox(height: 20),
            Text("Order Type", style: text.titleMedium),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<OrderType>(
                    title: const Text(
                      "Reservation",
                      style: TextStyle(fontSize: 15),
                    ),
                    value: OrderType.reservation,
                    groupValue: _orderType,
                    onChanged: (v) => setState(() => _orderType = v!),
                  ),
                ),
                Expanded(
                  child: RadioListTile<OrderType>(
                    title: const Text("Urgent", style: TextStyle(fontSize: 15)),
                    value: OrderType.urgent,
                    groupValue: _orderType,
                    onChanged: (v) => setState(() => _orderType = v!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text("Payment Method", style: text.titleMedium),
            const SizedBox(height: 8),
            _paymentTile(
              title: "Telda",
              subtitle: "Fast and easy",
              icon: Image.asset("images/01.png", width: 55),
              value: PaymentMethod.telda,
            ),
            const SizedBox(height: 10),
            _paymentTile(
              title: "VISA",
              subtitle: "Card Payment",
              icon: Image.asset("images/03.png", width: 55),
              value: PaymentMethod.visa,
            ),
            const SizedBox(height: 10),
            _paymentTile(
              title: "Mastercard",
              subtitle: "Card Payment",
              icon: Image.asset("images/02.png", width: 55),
              value: PaymentMethod.mastercard,
            ),
            const SizedBox(height: 25),
            Form(key: _formKey, child: _cardForm(text)),
            const SizedBox(height: 20),
            _payBtn(primary, text),
            const SizedBox(height: 10),
            Center(
              child: Text("All rights reserved 2025", style: text.bodySmall),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- SUMMARY ----------------
  Widget _summaryCard(TextTheme text, Color primary) {
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
            style: text.titleMedium!.copyWith(color: primary),
          ),
          const SizedBox(height: 10),
          _row("Service Type", "AB+ Blood Bag"),
          _row("Amount", "${_amount.toStringAsFixed(0)} EGP"),
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

  // ---------------- PAYMENT TILE ----------------
  Widget _paymentTile({
    required String title,
    required String subtitle,
    required Widget icon,
    required PaymentMethod value,
  }) {
    final selected = _selected == value;
    final primary = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: () => setState(() {
        _selected = value;
        _clearCardData();
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected ? primary : Colors.white,
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
              onChanged: (v) => setState(() {
                _selected = v!;
                _clearCardData();
              }),
              activeColor: selected ? Colors.white : primary,
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- CARD FORM ----------------
  Widget _cardForm(TextTheme text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            "Card Details",
            style: text.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _cardNumberController,
            keyboardType: TextInputType.number,
            maxLength: 19,
            onChanged: _formatCardNumber,
            decoration: _input("●●●● ●●●● ●●●● ●●●●"),
            validator: (value) {
              if (value == null || value.isEmpty) return "Enter card number";
              if (value.replaceAll(" ", "").length != 16)
                return "Card must be 16 digits";
              return null;
            },
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _expiryController,
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  onChanged: _formatExpiry,
                  decoration: _input("MM/YY"),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Enter expiry";
                    if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$').hasMatch(value))
                      return "Invalid format";
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 100,
                child: TextFormField(
                  controller: _cvvController,
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  obscureText: true,
                  decoration: _input("CVV"),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Enter CVV";
                    if (value.length != 3) return "3 digits";
                    return null;
                  },
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
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  );

  // ---------------- PAY BUTTON ----------------
  Widget _payBtn(Color primary, TextTheme text) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: _onPayPressed,
        child: Text(
          "Pay Now",
          style: text.bodyLarge!.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  // ---------------- PAY LOGIC ----------------
  void _onPayPressed() {
    if (!_formKey.currentState!.validate()) return;

    final method = _selected == PaymentMethod.telda
        ? "Telda"
        : _selected == PaymentMethod.visa
        ? "VISA"
        : "Mastercard";
    final order = _orderType == OrderType.reservation
        ? "Reservation"
        : "Urgent";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Confirm Payment"),
        content: Text(
          "Amount: ${_amount.toStringAsFixed(0)} EGP\nPayment Method: $method\nOrder Type: $order",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx, rootNavigator: true).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx, rootNavigator: true).pop();
              Future.delayed(const Duration(milliseconds: 150), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => InvoicePage(
                      amount: _amount,
                      method: method,
                      orderType: order,
                    ),
                  ),
                );
              });
            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}

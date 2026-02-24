import 'package:flutter/material.dart';
import 'invoice_page.dart';

const Color primaryColor = Color(0xFF00A7B3);

class PayNow extends StatelessWidget {
  final String bloodType;
  final String hospital;
  final int quantity;
  final DateTime receiveDate;
  final String orderType;
  final String? deliveryAddress;
  final double? deliveryFee;

  const PayNow({
    super.key,
    required this.bloodType,
    required this.hospital,
    required this.quantity,
    required this.receiveDate,
    required this.orderType,
    this.deliveryAddress,
    this.deliveryFee,
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
          orderType: orderType,
          deliveryAddress: deliveryAddress,
          deliveryFee: deliveryFee,
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
  final String orderType;
  final String? deliveryAddress;
  final double? deliveryFee;

  const PaymentScreen({
    super.key,
    required this.bloodType,
    required this.hospital,
    required this.quantity,
    required this.receiveDate,
    required this.orderType,
    this.deliveryAddress,
    this.deliveryFee,
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

  double get totalAmount {
    double total = _amountPerBag * widget.quantity;
    if (widget.deliveryFee != null) {
      total += widget.deliveryFee!;
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    // إضافة مستمعين للتنسيق التلقائي
    _cardNumber.addListener(_formatCardNumber);
    _expiry.addListener(_formatExpiryDate);
  }

  @override
  void dispose() {
    _cardNumber.removeListener(_formatCardNumber);
    _expiry.removeListener(_formatExpiryDate);
    _cardNumber.dispose();
    _expiry.dispose();
    _cvv.dispose();
    super.dispose();
  }

  // دالة تنسيق رقم البطاقة (إضافة مسافة كل 4 أرقام)
  void _formatCardNumber() {
    String text = _cardNumber.text.replaceAll(RegExp(r'\s+\b|\b\s'), '');
    if (text.isEmpty) return;

    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted += ' ';
      }
      formatted += text[i];
    }

    if (_cardNumber.text != formatted) {
      _cardNumber.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  // دالة تنسيق تاريخ الانتهاء (إضافة / بعد الشهر)
  void _formatExpiryDate() {
    String text = _expiry.text.replaceAll(RegExp(r'[^\d]'), '');
    if (text.isEmpty) return;

    if (text.length >= 3) {
      String month = text.substring(0, 2);
      String year = text.substring(2, text.length > 4 ? 4 : text.length);

      // التأكد من أن الشهر بين 01 و 12
      if (month.isNotEmpty) {
        int monthInt = int.parse(month);
        if (monthInt > 12) {
          month = '12';
        } else if (monthInt < 1 && month.length == 2) {
          month = '01';
        }
      }

      String formatted = text.length >= 2 ? '$month/$year' : text;

      if (_expiry.text != formatted) {
        _expiry.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
    }
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

          _row("Order Type", widget.orderType),
          _row("Blood Type", widget.bloodType),
          _row("Hospital", widget.hospital),
          _row("Quantity", "${widget.quantity} bag(s)"),
          if (widget.deliveryAddress != null)
            _row("Delivery Address", widget.deliveryAddress!),
          _row(
            "Receive Date",
            "${widget.receiveDate.day}/${widget.receiveDate.month}/${widget.receiveDate.year}",
          ),
          if (widget.deliveryFee != null)
            _row("Delivery Fee", "${widget.deliveryFee} EGP"),
          _row("Total Amount", "${totalAmount.toStringAsFixed(0)} EGP"),
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
          _cardNumber.clear();
          _expiry.clear();
          _cvv.clear();
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
                  _cardNumber.clear();
                  _expiry.clear();
                  _cvv.clear();
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

          // حقل رقم البطاقة مع التنسيق التلقائي
          TextFormField(
            controller: _cardNumber,
            keyboardType: TextInputType.number,
            maxLength: 19,
            decoration: _input("Card Number (xxxx xxxx xxxx xxxx)"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter card number';
              }
              String numbers = value.replaceAll(' ', '');
              if (numbers.length < 16) {
                return 'Card number must be 16 digits';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),

          Row(
            children: [
              // حقل تاريخ الانتهاء مع التنسيق التلقائي
              Expanded(
                child: TextFormField(
                  controller: _expiry,
                  keyboardType: TextInputType.number,
                  maxLength: 5, // MM/YY = 5 أحرف
                  decoration: _input("Expiry (MM/YY)"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    String numbers = value.replaceAll('/', '');
                    if (numbers.length < 4) {
                      return 'Invalid date';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12),

              // حقل CVV
              Expanded(
                child: TextFormField(
                  controller: _cvv,
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  obscureText: true,
                  decoration: _input("CVV"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    if (value.length < 3) {
                      return '3 digits';
                    }
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
    filled: true,
    fillColor: const Color(0xFFF8F8F8),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    errorStyle: const TextStyle(fontSize: 12),
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
    if (_formKey.currentState!.validate()) {
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
            orderType: widget.orderType,
            bloodType: widget.bloodType,
            hospital: widget.hospital,
            quantity: widget.quantity,
            receiveDate: widget.receiveDate,
            deliveryAddress: widget.deliveryAddress,
          ),
        ),
      );
    }
  }
}

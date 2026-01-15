import 'package:flutter/material.dart';
import 'invoice_page.dart';

/// PayNow: Wrapper بدون MaterialApp
class PayNow extends StatelessWidget {
  const PayNow({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: 'Tajawal',
        scaffoldBackgroundColor: const Color(0xFFF7F7F8),

        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          displayMedium: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          titleLarge: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
          bodyLarge: TextStyle(
            fontSize: 20.0,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: TextStyle(fontSize: 18.0, color: Colors.black87),
          bodySmall: TextStyle(fontSize: 16.0, color: Colors.black54),
        ),

        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00A7B3)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
      ),

      themeMode: ThemeMode.light,

      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: PaymentScreen(),
      ),
    );
  }
}

// --------------------------------------------------------------
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

enum PaymentMethod { vodafone, visa, mastercard }

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethod _selected = PaymentMethod.vodafone;
  final double _amount = 200.0;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  // تنسيق تلقائي لرقم البطاقة
  void _formatCardNumber(String value) {
    value = value.replaceAll(" ", "");
    String newValue = "";
    for (int i = 0; i < value.length; i++) {
      newValue += value[i];
      if ((i + 1) % 4 == 0 && i != value.length - 1) {
        newValue += " ";
      }
    }

    _cardNumberController.value = TextEditingValue(
      text: newValue,
      selection: TextSelection.collapsed(offset: newValue.length),
    );
  }

  // تنسيق تاريخ الانتهاء
  void _formatExpiry(String value) {
    value = value.replaceAll("/", "");
    if (value.length >= 3) {
      value = value.substring(0, 2) + "/" + value.substring(2);
    }

    _expiryController.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeText = Theme.of(context).textTheme;
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
        automaticallyImplyLeading: true,
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
            Text('بنك الدم', style: themeText.titleLarge),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('الدفع', style: themeText.displayMedium),
            const SizedBox(height: 12),

            _buildSummaryCard(themeText, primary),

            const SizedBox(height: 18),

            Text('طريقة الدفع', style: themeText.titleMedium),
            const SizedBox(height: 12),

            _paymentTile(
              title: 'Vodafone Cash',
              subtitle: 'سهل وسريع',
              icon: Image.asset('images/01.png', width: 55),
              value: PaymentMethod.vodafone,
            ),
            const SizedBox(height: 10),

            _paymentTile(
              title: 'VISA',
              subtitle: 'الدفع بالبطاقة',
              icon: Image.asset('images/03.png', width: 55),
              value: PaymentMethod.visa,
            ),
            const SizedBox(height: 10),

            _paymentTile(
              title: 'Mastercard',
              subtitle: 'الدفع بالبطاقة',
              icon: Image.asset('images/02.png', width: 55),
              value: PaymentMethod.mastercard,
            ),

            const SizedBox(height: 25),

            if (_selected != PaymentMethod.vodafone)
              Form(key: _formKey, child: _buildCardForm(themeText)),

            const SizedBox(height: 20),
            _buildPayButton(primary, themeText),

            const SizedBox(height: 12),
            Center(
              child: Text(
                'جميع الحقوق محفوظة 2025',
                style: themeText.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ====================== Widgets ======================

  Widget _buildSummaryCard(TextTheme themeText, Color primary) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE7C6C6)),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'ملخص العملية',
            style: themeText.titleMedium!.copyWith(color: primary),
          ),
          const SizedBox(height: 10),
          _buildRow('نوع الخدمة', 'كيس دم فصيلة AB+'),
          const SizedBox(height: 8),
          _buildRow('المبلغ', '${_amount.toStringAsFixed(0)} جنيه'),
        ],
      ),
    );
  }

  Widget _buildRow(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left),
        Text(right, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _paymentTile({
    required String title,
    String? subtitle,
    required Widget icon,
    required PaymentMethod value,
  }) {
    final selected = _selected == value;
    final primary = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: () => setState(() => _selected = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: selected ? primary : Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 6)],
        ),
        padding: const EdgeInsets.all(14),
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
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : Colors.black87,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
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
              onChanged: (v) => setState(() => _selected = v!),
              activeColor: selected ? Colors.white : primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardForm(TextTheme themeText) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            'بيانات البطاقة',
            style: themeText.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          TextFormField(
            controller: _cardNumberController,
            keyboardType: TextInputType.number,
            maxLength: 19,
            onChanged: _formatCardNumber,
            decoration: _input('●●●● ●●●● ●●●● ●●●●'),
            validator: (value) {
              if (value == null || value.isEmpty) return 'أدخل رقم البطاقة';
              if (value.replaceAll(" ", "").length != 16) {
                return 'رقم البطاقة يجب أن يكون 16 رقم';
              }
              return null;
            },
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _expiryController,
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  onChanged: _formatExpiry,
                  decoration: _input('MM/YY'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'أدخل تاريخ الانتهاء';
                    }
                    if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$').hasMatch(value)) {
                      return 'تاريخ غير صالح';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12),

              SizedBox(
                width: 110,
                child: TextFormField(
                  controller: _cvvController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  maxLength: 3,
                  decoration: _input('CVV'),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'أدخل CVV';
                    if (value.length != 3) return 'CVV يجب أن يكون 3 أرقام';
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

  Widget _buildPayButton(Color primary, TextTheme themeText) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: _onPayPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          'إتمام الدفع',
          style: themeText.bodyLarge!.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  // ========== الدفع + إصلاح مشكلة الشاشة السوداء ==========
  void _onPayPressed() {
    if (_selected != PaymentMethod.vodafone) {
      if (!_formKey.currentState!.validate()) return;
    }

    final method = _selected == PaymentMethod.vodafone
        ? 'Vodafone Cash'
        : (_selected == PaymentMethod.visa ? 'VISA' : 'Mastercard');

    /// 🔥 أهم تعديلان تم دمجهما:
    /// 1) builder: (context) وليس (_) لمنع فقدان الـ context الحقيقي
    /// 2) استخدام Navigator.pop(context) بدل Navigator.of(context).pop()

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('تأكيد الدفع'),
        content: Text(
          'المبلغ: ${_amount.toStringAsFixed(0)} جنيه\nطريقة الدفع: $method',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // يغلق الـ dialog فقط
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => InvoicePage(amount: _amount, method: method),
                ),
              );
            },
            child: const Text('متابعة'),
          ),
        ],
      ),
    );
  }
}

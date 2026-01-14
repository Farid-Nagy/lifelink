import 'package:flutter/material.dart';
import 'invoice_page.dart';

/// PayNow is a simple wrapper that provides RTL directionality
/// and exposes the PaymentScreen so it can be pushed from the
/// app's main MaterialApp without nesting another one.

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

  // ==== NEW: Form + Controllers ====
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  // =================================

  @override
  Widget build(BuildContext context) {
    final themeText = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Icon(Icons.bloodtype, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Text('بنك الدم', style: themeText.titleLarge),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('الدفع', style: themeText.displayMedium),
              const SizedBox(height: 12),

              // Summary card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFF1D4D4)),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('نوع الخدمة', style: themeText.bodyMedium),
                        Text(
                          'كيس دم فصيله AB+ ',
                          style: themeText.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('المبلغ', style: themeText.bodyMedium),
                        Text(
                          '${_amount.toStringAsFixed(0)} جنيه',
                          style: themeText.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              Text('طريقة الدفع', style: themeText.titleMedium),
              const SizedBox(height: 12),

              // Vodafone Cash
              _paymentTile(
                title: 'Vodafone Cash ',
                subtitle: 'سهل وسريع',
                icon: Image.asset('images/01.png', width: 70, height: 70),
                value: PaymentMethod.vodafone,
              ),

              const SizedBox(height: 10),

              // Visa
              _paymentTile(
                title: 'VISA',
                subtitle: 'استخدام البطاقة',
                icon: Image.asset('images/03.png', width: 70, height: 70),
                value: PaymentMethod.visa,
              ),

              const SizedBox(height: 10),

              // Mastercard
              _paymentTile(
                title: 'Mastercard',
                subtitle: 'استخدام البطاقة',
                icon: Image.asset('images/02.png', width: 70, height: 70),
                value: PaymentMethod.mastercard,
              ),

              const SizedBox(height: 24),

              // =========================
              //     بطاقة الدفع (NEW)
              // =========================
              if (_selected != PaymentMethod.vodafone) ...[
                Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'بيانات البطاقة',
                          style: themeText.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // رقم البطاقة
                        TextFormField(
                          controller: _cardNumberController,
                          keyboardType: TextInputType.number,
                          maxLength: 16,
                          decoration: InputDecoration(
                            hintText: '●●●● ●●●● ●●●● ●●●●',
                            counterText: "",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'أدخل رقم البطاقة';
                            }
                            if (value.length != 16) {
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
                                decoration: InputDecoration(
                                  hintText: 'MM/YY',
                                  counterText: "",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'أدخل تاريخ الانتهاء';
                                  }
                                  if (!RegExp(
                                    r'^(0[1-9]|1[0-2])\/\d{2}$',
                                  ).hasMatch(value)) {
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
                                obscureText: true,
                                keyboardType: TextInputType.number,
                                maxLength: 3,
                                decoration: InputDecoration(
                                  hintText: 'CVV',
                                  counterText: "",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'أدخل CVV';
                                  }
                                  if (value.length != 3) {
                                    return 'CVV يجب أن يكون 3 أرقام';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],

              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _onPayPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 8,
                  ),
                  child: Text(
                    'إتمام الدفع',
                    style: themeText.bodyLarge!.copyWith(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Center(
                child: Text(
                  'جميع الحقوق محفوظة 2025',
                  textAlign: TextAlign.center,
                  style: themeText.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _paymentTile({
    required String title,
    String? subtitle,
    required Widget icon,
    required PaymentMethod value,
  }) {
    final bool selected = _selected == value;
    return GestureDetector(
      onTap: () => setState(() => _selected = value),
      child: Container(
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(color: const Color(0xFFDDE2E5)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : Colors.black87,
                    ),
                  ),
                  if (subtitle != null) const SizedBox(height: 4),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: selected ? Colors.white70 : Colors.black54,
                      ),
                    ),
                ],
              ),
            ),
            Radio<PaymentMethod>(
              value: value,
              groupValue: _selected,
              onChanged: (v) => setState(() => _selected = v!),
              activeColor: selected
                  ? Colors.white
                  : Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  // ====================================================
  //                NEW: الدفع + التحقق
  // ====================================================
  void _onPayPressed() {
    if (_selected != PaymentMethod.vodafone) {
      if (!_formKey.currentState!.validate()) {
        return; // يمنع الانتقال
      }
    }

    final method = _selected == PaymentMethod.vodafone
        ? 'Vodafone Cash'
        : (_selected == PaymentMethod.visa ? 'VISA' : 'Mastercard');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
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
              // إغلاق الـ Dialog بشكل مؤكد
              Navigator.of(context, rootNavigator: true).pop();

              // بعد الإغلاق — الانتقال لصفحة الفاتورة
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

import 'package:flutter/material.dart';
import '../state/shop_state.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final city = TextEditingController();
  String payment = 'Cash on Delivery';

  @override
  void dispose() {
    name.dispose(); phone.dispose(); address.dispose(); city.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shop = ShopScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const Text('Delivery details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
            const SizedBox(height: 14),
            TextFormField(controller: name, decoration: const InputDecoration(labelText: 'Full name', prefixIcon: Icon(Icons.person_outline)), validator: (v) => v == null || v.trim().isEmpty ? 'Enter your name' : null),
            const SizedBox(height: 12),
            TextFormField(controller: phone, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Phone number', prefixIcon: Icon(Icons.phone_outlined)), validator: (v) => v == null || v.trim().length < 10 ? 'Enter a valid phone number' : null),
            const SizedBox(height: 12),
            TextFormField(controller: address, maxLines: 2, decoration: const InputDecoration(labelText: 'Address', prefixIcon: Icon(Icons.location_on_outlined)), validator: (v) => v == null || v.trim().isEmpty ? 'Enter your address' : null),
            const SizedBox(height: 12),
            TextFormField(controller: city, decoration: const InputDecoration(labelText: 'City / PIN code', prefixIcon: Icon(Icons.location_city_outlined)), validator: (v) => v == null || v.trim().isEmpty ? 'Enter city and PIN code' : null),
            const SizedBox(height: 24),
            const Text('Payment method', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Card(child: RadioListTile<String>(value: 'Cash on Delivery', groupValue: payment, onChanged: (v) => setState(() => payment = v!), title: const Text('Cash on Delivery'), secondary: const Icon(Icons.payments_outlined))),
            Card(child: RadioListTile<String>(value: 'UPI (demo)', groupValue: payment, onChanged: (v) => setState(() => payment = v!), title: const Text('UPI payment (demo only)'), secondary: const Icon(Icons.account_balance_wallet_outlined))),
            const SizedBox(height: 18),
            Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Order total'), Text('₹${shop.total.toStringAsFixed(0)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900))]),
              const SizedBox(height: 6),
              const Text('Demo checkout: no real payment is processed.', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ]))),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) return;
                final orderTotal = shop.total;
                shop.clearCart();
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (dialogContext) => AlertDialog(
                    icon: const Icon(Icons.check_circle, color: Colors.green, size: 52),
                    title: const Text('Order placed!'),
                    content: Text('Thank you, ${name.text.trim()}! Your demo order total is ₹${orderTotal.toStringAsFixed(0)}. Payment: $payment.'),
                    actions: [FilledButton(onPressed: () {
                      Navigator.of(dialogContext).pop();
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    }, child: const Text('Continue shopping'))],
                  ),
                );
              },
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              child: const Text('Place order'),
            ),
          ],
        ),
      ),
    );
  }
}

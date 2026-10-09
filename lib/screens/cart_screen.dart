import 'package:flutter/material.dart';
import '../state/shop_state.dart';
import '../models/product.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shop = ShopScope.of(context);
    final products = shop.cartProducts;
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart', style: TextStyle(fontWeight: FontWeight.w900))),
      body: products.isEmpty
          ? const _EmptyCart()
          : Column(children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: products.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, i) {
                    final p = products[i];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(children: [
                          Container(width: 78, height: 86, decoration: BoxDecoration(color: Color(p.colorValue), borderRadius: BorderRadius.circular(14)), child: Center(child: Text(p.emoji, style: const TextStyle(fontSize: 37)))),
                          const SizedBox(width: 12),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(p.name, style: const TextStyle(fontWeight: FontWeight.w800)),
                            const SizedBox(height: 5),
                            Text('₹${p.price.toStringAsFixed(0)}', style: const TextStyle(color: Color(0xFF6C3CE9), fontWeight: FontWeight.w800)),
                            const SizedBox(height: 8),
                            Row(children: [
                              _QtyButton(icon: Icons.remove, onTap: () => shop.decrement(p)),
                              Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text('${shop.quantityOf(p)}', style: const TextStyle(fontWeight: FontWeight.bold))),
                              _QtyButton(icon: Icons.add, onTap: () => shop.addToCart(p)),
                            ]),
                          ])),
                          IconButton(onPressed: () => shop.removeFromCart(p), icon: const Icon(Icons.delete_outline, color: Colors.red)),
                        ]),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
                decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xFFECE8F5)))),
                child: Column(children: [
                  _PriceLine(label: 'Subtotal', value: shop.subtotal),
                  const SizedBox(height: 7),
                  _PriceLine(label: 'Delivery', value: shop.shipping),
                  const Divider(height: 22),
                  _PriceLine(label: 'Total', value: shop.total, bold: true),
                  const SizedBox(height: 14),
                  SizedBox(width: double.infinity, child: FilledButton(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CheckoutScreen())),
                    style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: const Text('Continue to checkout  →'),
                  )),
                ]),
              ),
            ]),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(8),
    child: Container(width: 28, height: 28, decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE4DEEF)), borderRadius: BorderRadius.circular(8)), child: Icon(icon, size: 16)),
  );
}

class _PriceLine extends StatelessWidget {
  const _PriceLine({required this.label, required this.value, this.bold = false});
  final String label;
  final double value;
  final bool bold;
  @override
  Widget build(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(label, style: TextStyle(fontWeight: bold ? FontWeight.w900 : FontWeight.normal, fontSize: bold ? 17 : 14)),
    Text('₹${value.toStringAsFixed(0)}', style: TextStyle(fontWeight: bold ? FontWeight.w900 : FontWeight.w700, fontSize: bold ? 19 : 14)),
  ]);
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();
  @override
  Widget build(BuildContext context) => Center(child: Padding(
    padding: const EdgeInsets.all(30),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('🛍️', style: TextStyle(fontSize: 76)),
      const SizedBox(height: 14),
      const Text('Your cart is waiting', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
      const SizedBox(height: 7),
      const Text('Add something you love and it will appear here.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
      const SizedBox(height: 20),
      FilledButton(onPressed: () => Navigator.of(context).maybePop(), child: const Text('Keep shopping')),
    ]),
  ));
}

import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/shop_state.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final shop = ShopScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Product details')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(color: Color(product.colorValue), borderRadius: BorderRadius.circular(26)),
            child: Center(child: Text(product.emoji, style: const TextStyle(fontSize: 120))),
          ),
          const SizedBox(height: 20),
          Text(product.category.toUpperCase(), style: const TextStyle(color: Color(0xFF6C3CE9), fontWeight: FontWeight.w800, letterSpacing: 1.2)),
          const SizedBox(height: 6),
          Text(product.name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          Row(children: [
            const Icon(Icons.star_rounded, color: Color(0xFFFFB300), size: 20),
            Text(' ${product.rating}  ·  120+ reviews', style: const TextStyle(color: Colors.grey)),
          ]),
          const SizedBox(height: 14),
          Row(children: [
            Text('₹${product.price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
            const SizedBox(width: 10),
            Text('₹${product.oldPrice.toStringAsFixed(0)}', style: const TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough)),
            const SizedBox(width: 10),
            if (product.discountPercent > 0) Text('${product.discountPercent}% off', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 18),
          const Text('Product description', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
          const SizedBox(height: 7),
          Text(product.description, style: const TextStyle(height: 1.5, color: Color(0xFF6C6577))),
          const SizedBox(height: 22),
          Row(children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => shop.toggleFavorite(product),
                icon: Icon(shop.isFavorite(product) ? Icons.favorite : Icons.favorite_border),
                label: Text(shop.isFavorite(product) ? 'Saved' : 'Wishlist'),
                style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: FilledButton.icon(
                onPressed: () {
                  shop.addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to your cart')));
                },
                icon: const Icon(Icons.shopping_bag_outlined),
                label: const Text('Add to cart'),
                style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15)),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

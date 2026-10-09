import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/shop_state.dart';
import '../screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final shop = ShopScope.of(context);
    final bg = Color(product.colorValue);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ProductDetailScreen(product: product),
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 132,
                  width: double.infinity,
                  color: bg,
                  alignment: Alignment.center,
                  child: Text(product.emoji, style: const TextStyle(fontSize: 58)),
                ),
                if (product.discountPercent > 0)
                  Positioned(
                    top: 9,
                    left: 9,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C3CE9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('${product.discountPercent}% OFF',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton.filledTonal(
                    visualDensity: VisualDensity.compact,
                    onPressed: () => shop.toggleFavorite(product),
                    icon: Icon(shop.isFavorite(product) ? Icons.favorite : Icons.favorite_border,
                        color: shop.isFavorite(product) ? Colors.red : null, size: 19),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 9, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.category.toUpperCase(),
                      style: const TextStyle(fontSize: 9, letterSpacing: 1, color: Color(0xFF777184), fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text('₹${product.price.toStringAsFixed(0)}',
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text('₹${product.oldPrice.toStringAsFixed(0)}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 10, color: Colors.grey, decoration: TextDecoration.lineThrough)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.tonalIcon(
                      onPressed: () {
                        shop.addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('${product.name} added to cart'),
                          duration: const Duration(milliseconds: 900),
                        ));
                      },
                      icon: const Icon(Icons.add_shopping_cart, size: 16),
                      label: const Text('Add to cart', style: TextStyle(fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

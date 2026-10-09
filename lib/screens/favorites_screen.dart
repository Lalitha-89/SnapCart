import 'package:flutter/material.dart';
import '../state/shop_state.dart';
import '../widgets/product_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shop = ShopScope.of(context);
    final products = shop.favoriteProducts;
    final width = MediaQuery.sizeOf(context).width;
    final columns = width >= 900 ? 4 : width >= 620 ? 3 : 2;
    return Scaffold(
      appBar: AppBar(title: const Text('My Wishlist', style: TextStyle(fontWeight: FontWeight.w900))),
      body: products.isEmpty
          ? const Center(child: Padding(padding: EdgeInsets.all(30), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('💜', style: TextStyle(fontSize: 70)),
              SizedBox(height: 14),
              Text('Save your favorites', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
              SizedBox(height: 7),
              Text('Tap the heart on a product to keep it here.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
            ])))
          : GridView.builder(
              padding: const EdgeInsets.all(14),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columns, crossAxisSpacing: 10, mainAxisSpacing: 10, mainAxisExtent: 268),
              itemBuilder: (_, i) => ProductCard(product: products[i]),
            ),
    );
  }
}

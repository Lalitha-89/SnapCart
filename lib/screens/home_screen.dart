import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/shop_state.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const categories = ['All', 'Fashion', 'Footwear', 'Electronics', 'Accessories', 'Beauty', 'Home'];

  @override
  Widget build(BuildContext context) {
    final shop = ShopScope.of(context);
    final products = shop.visibleProducts;
    final width = MediaQuery.sizeOf(context).width;
    final columns = width >= 900 ? 4 : width >= 620 ? 3 : 2;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 8),
            child: Row(
              children: [
                Container(
                  height: 43, width: 43,
                  decoration: BoxDecoration(color: const Color(0xFF6C3CE9), borderRadius: BorderRadius.circular(14)),
                  child: const Icon(Icons.shopping_cart_rounded, color: Colors.white, size: 25),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('SnapCart', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: -0.7)),
                    Text('Shop smart, live better', style: TextStyle(fontSize: 11, color: Color(0xFF777184))),
                  ]),
                ),
                IconButton(onPressed: () => shop.setCategory('All'), icon: const Icon(Icons.notifications_none_rounded)),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 14),
            child: TextField(
              onChanged: shop.setQuery,
              decoration: const InputDecoration(
                hintText: 'Search dresses, sneakers, gadgets...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.tune_rounded),
              ),
            ),
          ),
        ),
        if (shop.query.isEmpty && shop.category == 'All')
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(
                height: 174,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF6C3CE9), Color(0xFFB34CE5)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(30)), child: const Text('NEW SEASON', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1))),
                        const SizedBox(height: 10),
                        const Text('Your style,\\nyour savings.', style: TextStyle(color: Colors.white, fontSize: 25, height: 1.05, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 8),
                        const Text('Fresh finds up to 40% off', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ]),
                    ),
                    const Text('🛍️', style: TextStyle(fontSize: 72)),
                  ],
                ),
              ),
            ),
          ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 20, 18, 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Shop by category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              Text('${categories.length - 1} categories', style: const TextStyle(color: Colors.grey, fontSize: 11)),
            ]),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 92,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, i) {
                final cat = categories[i];
                final selected = shop.category == cat;
                const icons = [Icons.grid_view_rounded, Icons.checkroom_rounded, Icons.directions_run_rounded, Icons.headphones_rounded, Icons.watch_rounded, Icons.spa_rounded, Icons.chair_rounded];
                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => shop.setCategory(cat),
                  child: Container(
                    width: 76,
                    decoration: BoxDecoration(
                      color: selected ? const Color(0xFF6C3CE9) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: selected ? const Color(0xFF6C3CE9) : const Color(0xFFECE8F5)),
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(icons[i], color: selected ? Colors.white : const Color(0xFF6C3CE9), size: 23),
                      const SizedBox(height: 7),
                      Text(cat, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: selected ? Colors.white : const Color(0xFF5D566B))),
                    ]),
                  ),
                );
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 20, 18, 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(shop.query.isNotEmpty ? 'Search results' : shop.category == 'All' ? 'Popular picks' : shop.category,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              Text('${products.length} items', style: const TextStyle(color: Colors.grey, fontSize: 11)),
            ]),
          ),
        ),
        if (products.isEmpty)
          const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(32), child: Center(child: Text('No products found. Try another search.'))))
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 22),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, i) => ProductCard(product: products[i]),
                childCount: products.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 268,
              ),
            ),
          ),
      ],
    );
  }
}

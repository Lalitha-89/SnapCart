import 'package:flutter/material.dart';
import '../models/product.dart';

class ShopState extends ChangeNotifier {
  final Map<String, int> _cart = {};
  final Set<String> _favorites = {};
  String _category = 'All';
  String _query = '';

  Map<String, int> get cart => Map.unmodifiable(_cart);
  Set<String> get favorites => Set.unmodifiable(_favorites);
  String get category => _category;
  String get query => _query;

  int get cartCount => _cart.values.fold(0, (sum, qty) => sum + qty);

  List<Product> get visibleProducts {
    return sampleProducts.where((p) {
      final categoryMatch = _category == 'All' || p.category == _category;
      final q = _query.trim().toLowerCase();
      final queryMatch = q.isEmpty ||
          p.name.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q);
      return categoryMatch && queryMatch;
    }).toList();
  }

  List<Product> get favoriteProducts =>
      sampleProducts.where((p) => _favorites.contains(p.id)).toList();

  List<Product> get cartProducts =>
      sampleProducts.where((p) => _cart.containsKey(p.id)).toList();

  int quantityOf(Product p) => _cart[p.id] ?? 0;

  double get subtotal => cartProducts.fold(
      0, (sum, product) => sum + product.price * quantityOf(product));

  double get shipping => _cart.isEmpty || subtotal >= 1999 ? 0 : 79;
  double get total => subtotal + shipping;

  void setCategory(String value) {
    _category = value;
    notifyListeners();
  }

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  void addToCart(Product product) {
    _cart.update(product.id, (qty) => qty + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  void decrement(Product product) {
    final qty = _cart[product.id] ?? 0;
    if (qty <= 1) {
      _cart.remove(product.id);
    } else {
      _cart[product.id] = qty - 1;
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cart.remove(product.id);
    notifyListeners();
  }

  void toggleFavorite(Product product) {
    if (!_favorites.add(product.id)) _favorites.remove(product.id);
    notifyListeners();
  }

  bool isFavorite(Product product) => _favorites.contains(product.id);

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}

class ShopScope extends InheritedNotifier<ShopState> {
  const ShopScope({super.key, required ShopState state, required super.child})
      : super(notifier: state);

  static ShopState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ShopScope>();
    assert(scope != null, 'ShopScope not found in widget tree');
    return scope!.notifier!;
  }
}

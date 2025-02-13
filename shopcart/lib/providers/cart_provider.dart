import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _items = [];
  final Map<int, int> _quantities = {}; // Track product quantities

  List<Product> get items => _items;

  double get totalPrice {
    return _items.fold(0,
        (total, product) => total + (product.price * _quantities[product.id]!));
  }

  void addToCart(Product product) {
    if (_quantities.containsKey(product.id)) {
      _quantities[product.id] = _quantities[product.id]! + 1;
    } else {
      _items.add(product);
      _quantities[product.id] = 1;
    }
    notifyListeners();
  }

  void decreaseQuantity(Product product) {
    if (_quantities.containsKey(product.id) && _quantities[product.id]! > 1) {
      _quantities[product.id] = _quantities[product.id]! - 1;
    } else {
      _items.remove(product);
      _quantities.remove(product.id);
    }
    notifyListeners();
  }

  int getQuantity(Product product) {
    return _quantities[product.id] ?? 0;
  }

  void removeFromCart(Product product) {
    _items.remove(product);
    _quantities.remove(product.id);
    notifyListeners();
  }
}

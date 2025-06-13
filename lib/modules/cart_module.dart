import 'package:flutter/widgets.dart';
import 'package:petrol_app/model/cart_item_model.dart';

class CartModule extends ChangeNotifier {
  CartModule._init(); //obect

  static CartModule? _cacheBox; //storage

  static CartModule instance() {
    _cacheBox ??= CartModule._init();
    return _cacheBox!;
  }

  List<CartItemModel> cartItems = [];

  // add item
  bool addCartItem(CartItemModel item) {
    bool exist =
        cartItems.where((val) => val.uniqueId == item.uniqueId).isNotEmpty;
    if (!exist) {
      cartItems.add(item);
      notifyListeners();
      return true;
    }

    return false;
  }

  // For ProductsPage – allow duplicates by increasing quantity
  bool addOrUpdateCartItem(CartItemModel item) {
    final index = cartItems.indexWhere((val) => val.uniqueId == item.uniqueId);

    if (index != -1) {
      // Update existing item
      final existing = cartItems[index];
      existing.quantity += item.quantity;
      existing.totalAmount = existing.price * existing.quantity;
    } else {
      // Add new item
      cartItems.add(item);
    }
    notifyListeners();
    return true;
  }

  // remove item
  bool removeCartItem(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems.removeAt(index);
      notifyListeners();
      return true;
    }
    return false;
  }

  // clear cart
  bool clearCart() {
    if (cartItems.isNotEmpty) {
      cartItems.clear();
      notifyListeners();
      return true;
    }
    return false;
  }

  // calculate total amount in the cartpage
  double get totalCartAmount {
    return cartItems.fold(0, (sum, item) => sum + item.totalAmount);
  }
}

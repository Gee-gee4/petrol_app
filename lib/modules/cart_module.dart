import 'package:petrol_app/model/cart_item_model.dart';

class CartModule {
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
      return true;
    }

    return false;
  }

  // remove item
  void removeCartItem(int index) {
    cartItems.removeAt(index);
  }

  // clear cart
  void clearCart() {
    cartItems.clear();
  }
}

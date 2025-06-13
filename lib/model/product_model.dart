import 'package:petrol_app/model/cart_item_model.dart';

class ProductModel {
  final String productName;
  final String productId;
  final double productQuantity;
  final double productPrice;
  final double productTotalPrice;
  ProductModel({
    required this.productName,
    required this.productId,
    required this.productQuantity,
    required this.productPrice,
    required this.productTotalPrice
  });

  CartItemModel convertToCartItemModel() {
  return CartItemModel(
    uniqueIdentifier: 'p_$productId:$productQuantity',
    productId: productId,
    productName: productName,
    price: productPrice,
    quantity: productQuantity, // Make sure this isn't always 1
    totalAmount: productPrice * productQuantity,
  );
}
}

final List<ProductModel> productsEx = [
  ProductModel(
    productName: 'Brake Fluid',
    productId: '1',
    productPrice: 450,
    productQuantity: 1,
    productTotalPrice: 450
  ),
  ProductModel(
    productName: 'Wiper Blades',
    productId: '2',
    productPrice: 700,
    productQuantity: 1,
    productTotalPrice: 700
  ),
  ProductModel(
    productName: 'Fuel Additive',
    productId: '3',
    productPrice: 600,
    productQuantity: 1,
    productTotalPrice: 600
  ),
  ProductModel(
    productName: 'Engine Oil',
    productId: '4',
    productPrice: 1200,
    productQuantity: 1,
    productTotalPrice: 1200,
  ),
];

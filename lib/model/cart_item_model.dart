class CartItemModel {
  CartItemModel({
    String? uniqueIdentifier,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.totalAmount,
  }) {
    uniqueId = uniqueIdentifier ?? '$productId:$quantity';
  }
  late String uniqueId;
  String productId;
  String productName;
  double price;
  double quantity;
  double totalAmount;
}

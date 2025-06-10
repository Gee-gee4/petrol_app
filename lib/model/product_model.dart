class ProductModel {
  final String productName;
  final String productId;
  ProductModel({required this.productName, required this.productId});
}
final List<ProductModel> productsEx = [
    ProductModel(productName: 'Lubricant', productId: '1'),
    ProductModel(productName: 'Oil', productId: '2'),
    ProductModel(productName: 'Freeze', productId: '3'),
    // ProductModel(productName: 'Tires', productId: '4'),
  ];


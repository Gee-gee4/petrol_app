import 'package:flutter/material.dart';
import 'package:petrol_app/model/product_model.dart';
import 'package:petrol_app/pages/service_product_display_page.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  Future<List<ProductModel>> loadProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return productsEx.map((product) => 
      ProductModel(
        productName: product.productName,
        productId: product.productId,
        productPrice: product.productPrice,
        productQuantity: 1, // Ensure quantity is set
        productTotalPrice: product.productPrice * 1,
      )
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ServiceProductDisplayPage<ProductModel>(
      appBarTitle: 'Products',
      imagePath: 'assets/vectors/product.png',
      loadItems: loadProducts,
      getTitle: (item) => item.productName,
      getPrice: (item) => item.productPrice,
      convertToCartItem: (item) => item.convertToCartItemModel(), // Use the model's method
    );
  }
}

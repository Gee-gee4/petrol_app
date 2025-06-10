import 'package:flutter/material.dart';
import 'package:petrol_app/model/product_model.dart';
import 'package:petrol_app/widgets/pump_card.dart';
import 'package:petrol_app/widgets/reusable_widgets.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<ProductModel> products = [];
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    loadDummyProducts();
  }

  void loadDummyProducts() async {
    setState(() {
      isLoading = true;
    });

// Simulate fetch delay
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      products = productsEx;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool narrowPhone = MediaQuery.of(context).size.width < 365;
    return Scaffold(
      extendBody: true,
      backgroundColor: hexToColor('d7eaee'),
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: Column(
        children: [
          if (isLoading)
            LinearProgressIndicator(
              color: hexToColor('005954'),
              backgroundColor: hexToColor('9fd8e1'),
            ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final currentProduct = products[index];
                return Padding(
                  padding: EdgeInsets.all(narrowPhone ? 0 : 8),
                  child: PumpCard(
                    model: currentProduct,
                    title: currentProduct.productName,
                    imagePath: 'assets/vectors/pump cropped.png',
                  ),
                );
              },
              itemCount: products.length,
            ),
          ),
        ],
      ),
    );
  }
}

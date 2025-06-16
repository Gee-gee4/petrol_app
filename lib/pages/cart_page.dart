import 'package:flutter/material.dart';
import 'package:petrol_app/modules/cart_module.dart';
import 'package:petrol_app/widgets/alert_box_trans.dart';
import 'package:petrol_app/widgets/reusable_widgets.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartModule cartModuleItems = CartModule.instance();

  @override
  Widget build(BuildContext context) {
    bool narrowPhone = MediaQuery.of(context).size.width < 350;

    return Scaffold(
      backgroundColor: hexToColor('d7eaee'),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                final wasCleared = cartModuleItems.clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        wasCleared
                            ? Text('Cart cleared successfully!')
                            : Text('Cart is already empty'),
                    duration: Duration(milliseconds: 1000),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor:
                        wasCleared ? hexToColor('005954') : Colors.grey,
                  ),
                );
              });
            },
            child: Text(
              'Clear All',
              style: TextStyle(fontSize: 17, color: hexToColor('005954')),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child:
                cartModuleItems.cartItems.isEmpty
                    ? Center(child: Text("No items in cart"))
                    : ListView.builder(
                      itemCount: cartModuleItems.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartModuleItems.cartItems[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                color: Colors.teal[50],
                                elevation: 2,
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  height: 100,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        item.productName,
                                        style: TextStyle(
                                          fontSize: narrowPhone ? 17 : 20,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Ksh ${item.price.toString()}',
                                            style: TextStyle(
                                              fontSize: narrowPhone ? 15 : 16,
                                            ),
                                          ),
                                          Text(
                                            'Quantity ${item.quantity.toString()}',
                                            style: TextStyle(
                                              fontSize: narrowPhone ? 15 : 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                      narrowPhone ? item.totalAmount.toStringAsFixed(2) : 'Ksh ${item.totalAmount.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: narrowPhone ? 17 : 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 12,
                                bottom: 2,
                                child: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      final wasRemoved = cartModuleItems
                                          .removeCartItem(index);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content:
                                              wasRemoved
                                                  ? Text(
                                                    'Deleted successfully!',
                                                  )
                                                  : Text(
                                                    'Error deleting product',
                                                  ),
                                          duration: Duration(
                                            milliseconds: 1000,
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          backgroundColor:
                                              wasRemoved
                                                  ? hexToColor('005954')
                                                  : Colors.grey,
                                        ),
                                      );
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.teal[50],
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.black12,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Total Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Amount",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Ksh ${cartModuleItems.totalCartAmount.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Checkout Button
            SizedBox(
              width: double.infinity,
              child: myButton(context, () {
                // handle checkout
                if (cartModuleItems.cartItems.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertBoxTrans(
                          cartItemTrans: cartModuleItems.cartItems,
                        ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('No products in cart'),
                      backgroundColor: Colors.grey,
                      duration: const Duration(milliseconds: 1000),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                }
              }, 'Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}

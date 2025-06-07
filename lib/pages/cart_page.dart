import 'package:flutter/material.dart';
import 'package:petrol_app/modules/cart_module.dart';
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
    return Scaffold(
      extendBody: true,
      backgroundColor: hexToColor('d7eaee'),
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final item = cartModuleItems.cartItems[index];
          return ListTile(
            title: Text(item.productName),
            subtitle: Text("Qty: ${item.quantity}"),
            trailing: Text("₦${item.totalAmount}"),
          );
        },
        itemCount: cartModuleItems.cartItems.length,
      ),
      // body: Column(
      //   children: [
      //     Expanded(
      //       child: SingleChildScrollView(
      //         child: Stack(
      //           children: [
      //             Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: Card(
      //                 shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(25),
      //                 ),
      //                 color: Colors.teal[50],
      //                 elevation: 2,
      //                 child: Container(
      //                   padding: EdgeInsets.all(12),
      //                   margin: EdgeInsets.symmetric(vertical: 5),
      //                   height: 100,
      //                   width: double.infinity,
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(25),
      //                   ),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                     children: [
      //                       Text('Super', style: TextStyle(fontSize: 22)),
      //                       Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         mainAxisAlignment: MainAxisAlignment.center,
      //                         children: [
      //                           Text(
      //                             "Ksh 169.63",
      //                             style: TextStyle(
      //                               fontSize: 16,
      //                               color: Colors.black87,
      //                             ),
      //                           ),
      //                           Text(
      //                             "Litres 1.76",
      //                             style: TextStyle(
      //                               fontSize: 16,
      //                               color: Colors.black87,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       Text(
      //                         "Ksh 300.00",
      //                         style: TextStyle(
      //                           fontSize: 18,
      //                           color: Colors.black87,
      //                           fontWeight: FontWeight.bold,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             Positioned(
      //               right: 16,
      //               bottom: 10,
      //               child: IconButton(
      //                 onPressed: () {},
      //                 icon: Icon(Icons.delete),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     // Bottom section
      //     Container(
      //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //       decoration: BoxDecoration(
      //         color: Colors.teal[50],
      //         boxShadow: [
      //           BoxShadow(
      //             blurRadius: 5,
      //             color: Colors.black12,
      //             offset: Offset(0, -2),
      //           ),
      //         ],
      //       ),
      //       child: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           // Total Price
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text(
      //                 "Total Amount",
      //                 style: TextStyle(
      //                   fontSize: 18,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //               Text(
      //                 "Ksh 300.00",
      //                 style: TextStyle(
      //                   fontSize: 18,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //             ],
      //           ),
      //           const SizedBox(height: 10),
      //           // Button
      //           SizedBox(
      //             width: double.infinity,
      //             child: myButton(context, () {}, 'Checkout'),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

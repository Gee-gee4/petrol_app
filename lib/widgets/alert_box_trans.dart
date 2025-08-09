import 'package:flutter/material.dart';
import 'package:petrol_app/enum.dart';
import 'package:petrol_app/model/cart_item_model.dart';
import 'package:petrol_app/modules/transaction_module.dart';
import 'package:petrol_app/pages/receipt_page.dart';
import 'package:petrol_app/widgets/reusable_widgets.dart';

class AlertBoxTrans extends StatefulWidget {
  final List<CartItemModel> cartItemTrans;
  const AlertBoxTrans({super.key, required this.cartItemTrans});

  @override
  State<AlertBoxTrans> createState() => _AlertBoxTransState();
}

class _AlertBoxTransState extends State<AlertBoxTrans> {
  final TextEditingController taxPayerTextController = TextEditingController();
  final TextEditingController tinTextController = TextEditingController();
  final TextEditingController phonenoTextController = TextEditingController();
  PaymentMethod? selectedPaymentMethod;
  bool isPosting = false;
  @override
  Widget build(BuildContext context) {
    return isPosting
        ? Dialog(
          child: LinearProgressIndicator(
            color: hexToColor('005954'),
            backgroundColor: hexToColor('9fd8e1'),
          ),
        )
        : AlertDialog(
          backgroundColor: hexToColor('d7eaee'),
          title: Text('Post Sales:-'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                reusableTextField(
                  'Tax payer name',
                  null,
                  true,
                  taxPayerTextController,
                ),
                SizedBox(height: 10),
                reusableTextField(
                  'Buyer\'s PIN',
                  null,
                  true,
                  tinTextController,
                ),
                SizedBox(height: 10),
                reusableTextField(
                  'Phone Number',
                  null,
                  true,
                  phonenoTextController,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 3),
                  child: Text('Payment Method:'),
                ),
                DropdownButtonFormField(
                  dropdownColor: hexToColor('d7eaee'),
                  borderRadius: BorderRadius.circular(25),
                  items:
                      PaymentMethod.values.map((method) {
                        return DropdownMenuItem(
                          value: method,
                          child: Text(method.val),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value;
                    });
                  },
                  value: selectedPaymentMethod,
                  isExpanded: true,
                  decoration: InputDecoration(
                    // labelText: 'Payment Method:',
                    // labelStyle: TextStyle(color: Colors.black, fontSize: 17),

                    // 🔹 Outline when not focused
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    // 🔹 Outline when focused (tapped)
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal.shade700,
                        width: 2.5,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Colors.teal[200],
                  ),
                ),

                // SizedBox(height: 20),
              ],
            ),
          ),
          actions: [
            cancelButtons(context, () {
              Navigator.pop(context);
            }, 'CANCEL'),
            dialogButtons(context, () async {
              final parentContext = context;

              final TransactionModule transactionModule = TransactionModule();
              setState(() {
                isPosting = true;
              });

              final res = await transactionModule.postTransaction(
                cartItemTrans: widget.cartItemTrans,
                taxPayerName: taxPayerTextController.text,
                tin: tinTextController.text,
                phoneNumber: phonenoTextController.text,
              );

              if (!mounted) return;

              Navigator.pop(parentContext); // Close current dialog

              if (res != null && parentContext.mounted) {
                Navigator.push(
                  parentContext,
                  MaterialPageRoute(
                    builder: (context) => ReceiptPage(receiptData: res),
                  ),
                );
              }
            }, 'POST'),
          ],
        );
  }
}

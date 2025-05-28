import 'package:flutter/material.dart';
import 'package:petrol_app/enum.dart';
import 'package:petrol_app/model/transaction_model.dart';
import 'package:petrol_app/modules/transaction_module.dart';
import 'package:petrol_app/widgets/reusable_widgets.dart';

class AlertBoxTrans extends StatefulWidget {
   final TransactionModel transaction;
  const AlertBoxTrans({super.key,required this.transaction});

  @override
  State<AlertBoxTrans> createState() => _AlertBoxTransState();
}

class _AlertBoxTransState extends State<AlertBoxTrans> {
  
  final TextEditingController taxPayerTextController = TextEditingController();
  final TextEditingController tinTextController = TextEditingController();
  final TextEditingController phonenoTextController = TextEditingController();
  PaymentMethod? selectedPaymentMethod;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: hexToColor('d7eaee'),
      title: Text('Post Sales:-'),
      content: SingleChildScrollView(
        child: StatefulBuilder(
          builder: (
            BuildContext context,
            void Function(void Function()) setState,
          ) {
            return Column(
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
                reusableTextField('TIN', null, true, tinTextController),
                SizedBox(height: 10),
                reusableTextField(
                  'Phone Number',
                  null,
                  true,
                  phonenoTextController,
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
                SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      cancelButtons(context, () {
                        Navigator.pop(context);
                      }, 'CANCEL'),
                      dialogButtons(context, () async {
                        final TransactionModule transactionModule =
                            TransactionModule();
                        await transactionModule.postTransaction(
                          transactionModel: widget.transaction,
                          taxPayerName: taxPayerTextController.text,
                          tin: tinTextController.text,
                          phoneNumber: phonenoTextController.text,
                        );
                        //post logic
                        if (context.mounted) Navigator.pop(context);
                      }, 'POST'),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

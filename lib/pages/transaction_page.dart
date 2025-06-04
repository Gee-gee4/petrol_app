import 'package:flutter/material.dart';
import 'package:petrol_app/model/transaction_model.dart';
import 'package:petrol_app/modules/transaction_module.dart';
import 'package:petrol_app/widgets/alert_box_trans.dart';
import 'package:petrol_app/widgets/reusable_widgets.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key, required this.pumpId});
  final String pumpId;
  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final TransactionModule _transactionModule = TransactionModule();
  List<TransactionModel> transactions = [];
  bool isFetching = false;

  @override
  void initState() {
    super.initState();
    isFetching = true;

    _transactionModule.fetchTransactions(widget.pumpId).then((items) {
      setState(() {
        isFetching = false;
        transactions = items;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: hexToColor('d7eaee'),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.filter_alt))],
      ),
      body: Column(
        children: [
          if (isFetching)
            LinearProgressIndicator(
              color: hexToColor('005954'),
              backgroundColor: hexToColor('9fd8e1'),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                TransactionModel transaction = transactions[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        color: Colors.teal[50],
                        elevation: 2,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25),
                          splashColor: Colors.teal[50],
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder:
                                  (context) =>
                                      AlertBoxTrans(transaction: transaction),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      transaction.productName,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      transaction.nozzle,
                                      style: TextStyle(
                                        fontSize: 25,
                                        //fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      transaction.dateTimeSold,
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      " Ksh${transaction.price}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      " Ksh${transaction.volume}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      " Ksh${transaction.totalAmount}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
    );
  }
}

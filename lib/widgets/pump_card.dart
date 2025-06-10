import 'package:flutter/material.dart';
import 'package:petrol_app/pages/transaction_page.dart';
import 'package:petrol_app/widgets/reusable_widgets.dart';

class PumpCard extends StatelessWidget {
  final dynamic model;
  final String title;        // Custom name like 'Pump 1', 'Oil Change', etc.
  final String imagePath;    // Path to asset like 'assets/icons/oil.png'

  const PumpCard({
    super.key,
    required this.model,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    bool narrowPhone = MediaQuery.of(context).size.width < 350;

    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionPage(pumpId: model.pumpId),
          ),
        );
      },
      child: Card(
        color: Colors.teal[50],
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: SizedBox(
          width: 120,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.fitWidth,
                  width: 48,
                  color: Colors.grey,
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 50,
                  width: 140,
                  child: myButton(
                    context,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransactionPage(pumpId: model.pumpId),
                        ),
                      );
                    },
                    'Transactions',
                    buttonTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: narrowPhone ? 12.1 : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


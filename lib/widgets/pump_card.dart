import 'package:flutter/material.dart';
import 'package:petrol_app/model/pump_model.dart';
import 'package:petrol_app/pages/transaction_page.dart';
import 'package:petrol_app/widgets/reusable_widgets.dart';

class PumpCard extends StatelessWidget {
  final PumpModel pump;
  const PumpCard({super.key, required this.pump});

  @override
  Widget build(BuildContext context) {
    bool narrowPhone = MediaQuery.of(context).size.width < 350;

    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionPage(pumpId: pump.pumpId),
          ),
        );
      },
      child: Card(
        color: Colors.teal[50],
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: SizedBox(
          // height: 150,
          width: 120,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Shrinks to fit children
              children: [
                Image.asset(
                  'assets/vectors/pump cropped.png',
                  fit: BoxFit.fitWidth,
                  width: 48,
                  color: Colors.grey,
                ),
                SizedBox(height: 6),
                Text(
                  pump.pumpName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
                SizedBox(height: 15),

                //Divider(thickness: 2),
                SizedBox(
                  height: 50,
                  width: 140,
                  child: myButton(context, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => TransactionPage(pumpId: pump.pumpId),
                      ),
                    );
                  }, 'Transactions',
                  buttonTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: narrowPhone ? 12.1 : null
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

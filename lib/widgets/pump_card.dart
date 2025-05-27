import 'package:flutter/material.dart';
import 'package:petrol_app/model/pump_model.dart';
import 'package:petrol_app/pages/transaction_page.dart';
import 'package:petrol_app/widgets/reusable_widgets.dart';

class PumpCard extends StatelessWidget {
   final PumpModel pump;
  const PumpCard({super.key, required this.pump});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[350],
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: SizedBox(
        height: 100,
        width: 50,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                'assets/vectors/pump cropped.png',
                fit: BoxFit.fitWidth,
                width: 48,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Text(
                pump.pumpName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
              SizedBox(height: 20),

              //Divider(thickness: 2),
              myButton(context, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransactionPage()),
                );
              }, 'Transactions'),
            ],
          ),
        ),
      ),
    );
  }
}

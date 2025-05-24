import 'package:flutter/material.dart';
import 'package:petrol_app/widgets/pump_card.dart';

class FuelPage extends StatelessWidget {
  const FuelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        itemCount: 5,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          // crossAxisSpacing: 0,
          // mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          return Padding(padding: const EdgeInsets.all(8.0), child: PumpCard());
        },
      ),
    );
  }
}

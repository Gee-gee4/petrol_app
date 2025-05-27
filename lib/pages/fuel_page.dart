import 'package:flutter/material.dart';
import 'package:petrol_app/model/pump_model.dart';
import 'package:petrol_app/modules/pumps_module.dart';
import 'package:petrol_app/widgets/pump_card.dart';

class FuelPage extends StatefulWidget {
  const FuelPage({super.key});

  @override
  State<FuelPage> createState() => _FuelPageState();
}

class _FuelPageState extends State<FuelPage> {
  final PumpsModule _pumpsModule = PumpsModule();
  List<PumpModel> pumps = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _pumpsModule.fetchPumps().then((ps) {
      setState(() {
        isLoading = false;
        pumps = ps;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: Column(
        children: [
          if(isLoading) LinearProgressIndicator(),
          Expanded(
            child: GridView.builder(
              itemCount: pumps.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                // crossAxisSpacing: 0,
                // mainAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
                return Padding(padding: const EdgeInsets.all(8.0), child: PumpCard(pump: pumps[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:petrol_app/model/pump_model.dart';
import 'package:petrol_app/modules/pumps_module.dart';
import 'package:petrol_app/pages/transaction_page.dart';
import 'package:petrol_app/widgets/pump_card.dart';
import 'package:petrol_app/widgets/reusable_widgets.dart';

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
    bool narrowPhone = MediaQuery.of(context).size.width < 365;
    return Scaffold(
      extendBody: true,
      backgroundColor: hexToColor('d7eaee'),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          InkWell(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TransactionPage(pumpId: 'all'),
                  ),
                ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6),
              width: 170,
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('All Transactions'),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => const TransactionPage(pumpId: 'all'),
                        ),
                      );
                    },
                    icon: Icon(Icons.receipt_long),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          if (isLoading)
            LinearProgressIndicator(
              color: hexToColor('005954'),
              backgroundColor: hexToColor('9fd8e1'),
            ),
          Expanded(
            child: GridView.builder(
              itemCount: pumps.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: narrowPhone ? .8 : .9,
                // crossAxisSpacing: 0,
                // mainAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
                final pumpCurrent = pumps[index];
                return Padding(
                  padding: EdgeInsets.all(narrowPhone ? 0 : 8),
                  child: PumpCard(
                    imagePath: 'assets/vectors/pump cropped.png',
                    imageWidth: 48,
                    title: pumpCurrent.pumpName,
                    model: pumpCurrent,
                    buttonName: 'Transactions',
                    cardOnTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  TransactionPage(pumpId: pumpCurrent.pumpId),
                        ),
                      );
                    },
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  TransactionPage(pumpId: pumpCurrent.pumpId),
                        ),
                      );
                    },
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

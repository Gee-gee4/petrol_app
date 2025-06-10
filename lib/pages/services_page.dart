import 'package:flutter/material.dart';
import 'package:petrol_app/model/services_model.dart';
import 'package:petrol_app/widgets/pump_card.dart';
import 'package:petrol_app/widgets/reusable_widgets.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  List<ServicesModel> services = [];
  bool isLoading = false;

@override
  void initState() {
    super.initState();
    loadDummyServices();
  }

  void loadDummyServices() async {
    setState(() {
      isLoading = true;
    });

// Simulate fetch delay
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      services = servicesEx;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool narrowPhone = MediaQuery.of(context).size.width < 365;
    return Scaffold(
      extendBody: true,
      backgroundColor: hexToColor('d7eaee'),
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: Column(
        children: [
          if (isLoading)
            LinearProgressIndicator(
              color: hexToColor('005954'),
              backgroundColor: hexToColor('9fd8e1'),
            ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final currentService = services[index];
                return Padding(
                  padding: EdgeInsets.all(narrowPhone ? 0 : 8),
                  child: PumpCard(
                    model: currentService,
                    title: currentService.serviceName,
                    imagePath: 'assets/vectors/person blue.png',
                  ),
                );
              },
              itemCount: services.length,
            ),
          ),
        ],
      ),
    );
  }
}

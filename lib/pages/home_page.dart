import 'package:flutter/material.dart';
import 'package:petrol_app/widgets/reusable_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        title: Text('Station Name'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome User,',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Choose your fuel type:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                myCard(
                  Text('Petrol'),
                  'assets/vectors/location login orange (enhanced).png',
                ),
                myCard(
                  Text('Diesel'),
                  'assets/vectors/location login orange (enhanced).png',
                ),
              ],
            ),
            SizedBox(height: 20,),
            Text(
              'Choose a service:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            myCard(Text('Services'),'assets/vectors/location login orange (enhanced).png')
          ],
        ),
      ),
    );
  }
}

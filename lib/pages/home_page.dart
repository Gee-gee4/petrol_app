import 'package:flutter/material.dart';
import 'package:petrol_app/pages/fuel_page.dart';
import 'package:petrol_app/widgets/reusable_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        title: Text('Station Name',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Image.asset('assets/vectors/green_home.png'),
              //Text('Welcome User,',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
               SizedBox(height: 20),
              myCard(
                Text('FUEL', style: TextStyle(fontWeight: FontWeight.bold)),
                'assets/vectors/fuel.png',
                'Super',
                'Diesel',
                ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>FuelPage()))
              ),
              SizedBox(height: 20),
             
              SizedBox(height: 20),
              myCard(
                Text('SERVICES', style: TextStyle(fontWeight: FontWeight.bold)),
                'assets/vectors/service.png',
                'Carwash',
                'Oil change',
                (){}
              ),
              SizedBox(height: 20),
              
              SizedBox(height: 20),
              myCard(
                Text('PRODUCTS', style: TextStyle(fontWeight: FontWeight.bold)),
                'assets/vectors/productss.png',
                'Lubes',
                'Anti-freeze',
                (){}
              ),
            ],
          ),
        ),
      ),
    );
  }
}

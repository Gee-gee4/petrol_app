import 'package:flutter/material.dart';
import 'package:petrol_app/pages/fuel_page.dart';
import 'package:petrol_app/pages/settings_page.dart';
import 'package:petrol_app/widgets/reusable_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final SharedPreferences sharedPreference;
  String stationName = 'Station Name';
  static String stationNameKey = 'stationName';

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      sharedPreference = value;
      stationName = sharedPreference.getString(stationNameKey) ?? stationName;
      stationName = stationName.isEmpty ? 'Station Name' : stationName;
      setState(() {});
    });
  }

  // @override
  // void didChangeDependencies() {
  //   // stationName = sharedPreference.getString(stationNameKey) ?? 'Station Name';
  //   // setState(() {});
  //   print('=================');
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    // final items = <Widget>[
    //   Icon(Icons.home, size: 30),
    //   Icon(Icons.receipt_long, size: 30),
    //   Icon(Icons.person, size: 30),
    // ];
    return Scaffold(
      extendBody: true,
      backgroundColor: hexToColor('d7eaee'),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          stationName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      // bottomNavigationBar: Theme(
      //   data: Theme.of(
      //     context,
      //   ).copyWith(iconTheme: IconThemeData(color: Colors.black87)),
      //   child: CurvedNavigationBar(
      //     color: Colors.green[100]!,
      //     buttonBackgroundColor: Colors.green[100],
      //     height: 50,
      //     animationCurve: Curves.easeInOut,
      //     animationDuration: Duration(milliseconds: 400),
      //     backgroundColor: Colors.transparent,
      //     items: items,
      //   ),
      // ),
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
                Text(
                  'FUEL',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
                ),
                'assets/vectors/pump blue.png',
                'Super',
                'Diesel',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FuelPage()),
                ),
              ),
              SizedBox(height: 20),
      
              SizedBox(height: 20),
              myCard(
                Text(
                  'SERVICES',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
                ),
                'assets/vectors/person blue.png',
                'Carwash',
                'Oil change',
                () {},
              ),
              SizedBox(height: 20),
      
              SizedBox(height: 20),
              myCard(
                Text(
                  'PRODUCTS',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
                ),
                'assets/vectors/product blue.png',
                'Lubes',
                'Anti-freeze',
                () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

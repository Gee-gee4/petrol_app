import 'package:flutter/material.dart';
import 'package:petrol_app/pages/home_page.dart';
import 'package:petrol_app/pages/settings_page.dart';
import 'package:petrol_app/widgets/reusable_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameTextController = TextEditingController();

  final TextEditingController _pinTextController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss the keyboard
      },
      child: Stack(
        children: [
          Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [hexToColor('9fd8e1'), hexToColor('1d837f')],
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    20,
                    MediaQuery.of(context).size.height * 0.2,
                    20,
                    20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Icon(Icons.settings),
                      logoAuth('assets/vectors/location login (teal).png'),
                      reusableTextField(
                        'Enter Name',
                        Icons.person,
                        true,
                        _nameTextController,
                      ),
                      SizedBox(height: 20),
                      reusableTextField(
                        'Enter Pin',
                        Icons.lock,
                        showPassword,
                        _pinTextController,
                        toggleOnOff: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                      SizedBox(height: 40),
                      myButton(
                        context,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        ),
                        'LOG IN',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50, // adjust as needed
            right: 20,
            child: FloatingActionButton(
              //splashColor: Colors.teal[50],
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()));
              },
              backgroundColor: Colors.teal[200],
              child: Icon(Icons.settings, color: hexToColor('005954'),),
            ),
          ),
        ],
      ),
    );
  }
}

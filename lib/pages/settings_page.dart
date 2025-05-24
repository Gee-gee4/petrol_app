import 'package:flutter/material.dart';
import 'package:petrol_app/widgets/reusable_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static String urlKey = 'tatsUrl';
  static String stationNameKey = 'stationName';
  static String stationIdKey = 'stationId';
  late final SharedPreferences sharedPreference;

  final TextEditingController _urlTextController = TextEditingController();

  final TextEditingController _stationNameTextController =
      TextEditingController();

  final TextEditingController _stationIdTextController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      sharedPreference = value;
      _urlTextController.text = sharedPreference.getString(urlKey) ?? '';
      _stationNameTextController.text =
          sharedPreference.getString(stationNameKey) ?? '';
      _stationIdTextController.text =
          sharedPreference.getString(stationIdKey) ?? '';
          setState(() {
            
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter the entries:-',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 20),
            reusableTextField('URL', null, true, _urlTextController),
            SizedBox(height: 10),
            reusableTextField(
              'Station Name',
              null,
              true,
              _stationNameTextController,
            ),
            SizedBox(height: 10),
            reusableTextField(
              'Station Id',
              null,
              true,
              _stationIdTextController,
            ),
            SizedBox(height: 20),
            myButton(context, () {
              sharedPreference.setString(urlKey, _urlTextController.text);
              sharedPreference.setString(
                stationNameKey,
                _stationNameTextController.text,
              );
              sharedPreference.setString(stationIdKey, _stationIdTextController.text);
            }, 'Save'),
          ],
        ),
      ),
    );
  }
}

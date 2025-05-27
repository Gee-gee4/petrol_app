import 'package:flutter/material.dart';
import 'package:petrol_app/utils/configs.dart';
import 'package:petrol_app/widgets/reusable_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final SharedPreferences sharedPreference;

  final TextEditingController _urlTextController = TextEditingController();

  final TextEditingController _stationNameTextController =
      TextEditingController();

  final TextEditingController _stationIdTextController =
      TextEditingController();
      final TextEditingController _durationTextController =
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
          _durationTextController.text =
          sharedPreference.getInt(durationKey)?.toString() ?? '';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
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
              SizedBox(height: 10),
              reusableTextField(
                'Fetch Transactions (minutes)',
                null,
                true,
                _durationTextController,
              ),
              SizedBox(height: 20),
              myButton(context, () {
                sharedPreference.setString(urlKey, _urlTextController.text);
                sharedPreference.setString(
                  stationNameKey,
                  _stationNameTextController.text,
                );
                sharedPreference.setString(
                  stationIdKey,
                  _stationIdTextController.text,
                );
                sharedPreference.setInt(
                  durationKey,
                  int.tryParse(_durationTextController.text) ?? 0,
                );
        
                //show a snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.green[400],
                    content: Text('Saved successfully!',),
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }, 'Save'),
            ],
          ),
        ),
      ),
    );
  }
}

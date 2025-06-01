// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:petrol_app/modules/auth_module.dart';
import 'package:petrol_app/pages/login_page.dart';
import 'package:petrol_app/utils/configs.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Hive.initFlutter().then((val) {
    final AuthModule authModule = AuthModule();
    authModule.login();
    SharedPreferences.getInstance().then((val) {
      final url = val.getString(urlKey);
      if(url != null){
        baseTatsUrl = url;
      }
    });
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petrol_app/model/pump_model.dart';
import 'package:petrol_app/modules/auth_module.dart';
import 'package:petrol_app/utils/configs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PumpsModule {
  final AuthModule _authModule = AuthModule();
  Future<List<PumpModel>> fetchPumps() async {
    List<PumpModel> items = [];

    try {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String stationName = sharedPreferences.getString(stationIdKey) ?? '';

      // fetch token
      String token = await _authModule.fetchToken();
      Map<String, String> headers = {'Content-type': 'application/json', 'authorization': 'Bearer $token'};

      final res = await http.get(Uri.parse(fetchPumpsUrl(stationName)), headers: headers);

      if (res.statusCode == 200) {
        Map body = Map.from(json.decode(res.body));
        List<Map> rawPumps = List<Map>.from(body['pumps'] ?? []);
        items = rawPumps.map((pump) => PumpModel(pumpName: pump['label'], pumpId: pump['rdgIndex'])).toList();
      }
    } catch (_) {
    }
    return items;
  }
}

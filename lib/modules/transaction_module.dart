// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petrol_app/model/cart_item_model.dart';
import 'package:petrol_app/model/transaction_model.dart';
import 'package:petrol_app/modules/auth_module.dart';
import 'package:petrol_app/utils/configs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionModule {
  final AuthModule _authModule = AuthModule();
  Future<List<TransactionModel>> fetchTransactions(String pumpId) async {
    List<TransactionModel> items = [];

    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String stationId = sharedPreferences.getString(stationIdKey) ?? '';
      int duration = sharedPreferences.getInt(durationKey) ?? 1000;

      DateTime toDate = DateTime.now();
      DateTime fromDate = toDate.subtract(Duration(minutes: duration));

      // fetch token
      String token = await _authModule.fetchToken();
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'authorization': 'Bearer $token',
      };

      final res = await http.get(
        Uri.parse(
          fetchTransactionsUrl(
            stationId: stationId,
            pumpId: pumpId,
            isPosted: false,
            fromDate: fromDate,
            toDate: toDate,
          ),
        ),
        headers: headers,
      );

      if (res.statusCode == 200) {
        List<Map> rawTransactions = List<Map>.from(json.decode(res.body) ?? []);
        items =
            rawTransactions
                .map(
                  (transaction) => TransactionModel(
                    transactionId: transaction['id']?.toString(),
                    nozzle: transaction['nozzle'].toString(),
                    productName: transaction['productName'].toString(),
                    productId: transaction['productId']?.toString(),
                    price:
                        double.tryParse(transaction['price'].toString()) ?? 0,
                    volume:
                        double.tryParse(transaction['volume'].toString()) ?? 0,
                    totalAmount:
                        double.tryParse(transaction['amount'].toString()) ?? 0,
                    dateTimeSold: transaction['dateTime'],
                  ),
                )
                .toList();
      }
    } catch (_) {}
    return items;
  }

  Future postTransaction({
    required List<CartItemModel> cartItemTrans,
    String? taxPayerName,
    String? tin,
    String? phoneNumber,
  }) async {
    try {
      String token = await _authModule.fetchToken();
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'authorization': 'Bearer $token',
      };

      final res = await http.put(
        Uri.parse(postTransactionUrl('0')),
        headers: headers,
        body: json.encode({
          "buyerName": taxPayerName,
          "buyerTIN": tin,
          "buyerPhone": phoneNumber,
        }),
      );

      print(res.statusCode);
      print(res.body);
      if(res.statusCode == 200){
        return json.decode(res.body);
      }
    } catch (e) {
      print(e);
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petrol_app/model/account_model.dart';
import 'package:petrol_app/modules/auth_module.dart';
import 'package:petrol_app/utils/configs.dart';
// import 'package:pie_tats_app/src/models/account_model.dart';
// import 'package:pie_tats_app/src/modules/auth_module.dart';
// import 'package:pie_tats_app/src/utils/configs.dart';

class AccountModule {

  // get account
  Future<AccountModel> getUser()async{
    AccountModel accountModel = AccountModel();
    return AccountModel.fromMap((await accountModel.get(AccountModel.key)) ?? {});
  }
  

  // fetch account from server
  Future<AccountModel?> fetchfromServer()async{
    try {
      // fetch token
      AuthModule authModule = AuthModule();
      final token = await authModule.fetchToken();
      Map<String, String> headers = {
        'Content-type' : 'application/json', 
        'authorization': 'Bearer $token'
      };

      final res = await http.get(Uri.parse(userInfoUrl), headers: headers);
      if(res.statusCode == 200){
        final body = json.decode(res.body);
        AccountType accountType = AccountType.normal;
        try {
          accountType = AccountType.values.byName(body['userType']);
        } catch (_) {}

        AccountModel accountModel = AccountModel(accountType: accountType, emailAddress: body['email']);

        // save the account
        await accountModel.put(AccountModel.key, accountModel.asMap());


        return accountModel;
      }

      
    } catch (_) {}
    return null;
  }
}
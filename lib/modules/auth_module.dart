import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petrol_app/model/token_model.dart';
import 'package:petrol_app/modules/account_module.dart';
import 'package:petrol_app/utils/configs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthModule {
  
  // login
  Future<LoginResponse> login({String email= 'gladysmbuthia324@gmail.com', String password = 'pass1234'})async{
    try {
      await fetchToken(grantType: GrantType.password, username: email, password: password);
      return LoginResponse(message: "Welcome", success: true);
    } on BadRequest catch(_){
      return LoginResponse(message: "Wrong credentials", success: false);
    } on InternalServerError catch(e){
      return LoginResponse(message: e.message ?? 'Server Error', success: false);
    } on TokenRequestError catch(e){
      return LoginResponse(message: e.toString(), success: false);
    } catch(e){
      return LoginResponse(message: 'Check your internet', success: false);
    }
  }


  // refresh token


  // logout
  Future<void> logout()async{
    TokenModel tokenModel = TokenModel();
    await tokenModel.delete(TokenModel.key);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(TokenModel.isLoggedIn, false);
  }




  Future<String> fetchToken({GrantType grantType = GrantType.refresh_token, String? username, String? password})async{
    // get token
    TokenModel tokenModel = TokenModel();
    tokenModel = TokenModel.fromMap((await tokenModel.get(TokenModel.key)) ?? {});

    // check if token exist
    if(tokenModel.token != null && tokenModel.isNotExpired){
      return tokenModel.token!;
    }

    // check if exist but expired then refresh token
    if(tokenModel.refreshToken != null && !tokenModel.isNotExpired){
      grantType = GrantType.refresh_token;
    }

    final Map<String, String> headers = {
            'Content-type' : 'application/x-www-form-urlencoded', 
            'authorization': basicAuthorization
          };

    final String grantTypeName = grantType.name;

    final Map<String, dynamic> body = {
            'grant_type' : grantTypeName, 
            'scope': 'transactions'
          };

    final Encoding? encoding = Encoding.getByName('utf-8');

    // dynamic body
    switch (grantType) {
      case GrantType.password:
        body.addAll({
          'username': username,
          'password': password,
        });
        break;
      case GrantType.refresh_token:
        body.addAll({
          'refresh_token': tokenModel.refreshToken,
        });
        break;
      }

    // send request
    try {
      final http.Response res = await oauth2Request(authUrl, headers, body, encoding);
      switch (res.statusCode) {
        // sucess
        case 200:
        case 201:
          var body = json.decode(res.body);
          tokenModel.token = body['access_token'];
          tokenModel.refreshToken = body['refresh_token'];
          // scopes = _body['scope'].toString().split(' ');
          tokenModel.expiry = DateTime.now().add(Duration(seconds: int.tryParse(body['expires_in'].toString()) ?? 0));

          // save token model
          await tokenModel.put(TokenModel.key, tokenModel.asMap());
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool(TokenModel.isLoggedIn, true);
          final AccountModule accountModule = AccountModule();
          accountModule.fetchfromServer();
          return tokenModel.token ?? '';
        case 400:
          throw BadRequest(res.body);
        case 500:
          throw InternalServerError(res.body);
        default:
          throw TokenRequestError(res.statusCode, res.body);
      }
    } catch (e) {
      rethrow;
    }

  }



  String get basicAuthorization{
    final base64E = base64Encode(utf8.encode('$consumerKey:$consumerSecret'));
    return 'Basic $base64E';
  }


  Future<http.Response> oauth2Request(String url, Map<String, String> headers, Map<String, dynamic> body, Encoding? encoding)async{
    try {
      return await http.post(Uri.parse(url), headers: headers, body: body, encoding: encoding);
    } catch (e) {
      rethrow;
    }
  }

}


class LoginResponse {
  LoginResponse({required this.message, required this.success});
  String message;
  bool success;
}


enum GrantType{
  // client_credentials,
  // code,
  password,
  // ignore: constant_identifier_names
  refresh_token
}


// exceptions
class Unauthorized implements Exception{
  @override
  String toString()=> 'Unauthorized';
}

class InternalServerError implements Exception{
  InternalServerError([this.message]);
  String? message;
  @override
  String toString()=> 'Internal Server Error: ${message ?? ""}';
}

class BadRequest implements Exception{
  BadRequest([this.message]);
  String? message;
  @override
  String toString()=> 'Bad Request: ${message ?? ""}';
}

class TokenRequestError implements Exception{
  TokenRequestError(this.statuscode, [this.message]);
  String? message;
  int statuscode;
  @override
  String toString()=> 'StatusCode: $statuscode, Message: ${message ?? ""}';
}
import 'dart:convert';

import 'package:async/src/result/result.dart';
import '../../domain/credential.dart';
import '../../infra/api/auth_api_contract.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http; 

class AuthApi implements IAuthApi {
  final http.Client _client;
  String baseUrl;

  AuthApi(this.baseUrl,this._client)

  @override
  Future<Result<String>> signIn(Credential credential) async {
    var endpoint = baseUrl + '/auth/signin';
    return await _postCredential(endpoint, credential)

  }

  @override
  Future<Result<String>> signUp(Credential credential) async {
    var endpoint = baseUrl + '/auth/signup';
    return await _postCredential(endpoint, credential);
  }

  Future<Result<String>> _postCredential(
      String endpoint, Credential credential ) async {
    var response  = 
      await _client.post(endpoint, body: Mapper.toJson(credential));

    if(response.statusCode != 200) return Result.error('Server Error');
    var json = jsonDecode(response.body);

    return json['auth_token'] != null 
        ? Result.value(json['auth_token'])
        : Result.error(json['message']);
  }
}

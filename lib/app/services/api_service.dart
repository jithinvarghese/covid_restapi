import 'dart:convert';

import 'package:covid_restapi/app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APIService {
  final API api;
  APIService({this.api});

  Future<String> getAccessToken() async {
    final response = await http.post(
      api.tokenUri().toString(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    print(
        'Request ${api.tokenUri()} \n status code = ${response.statusCode} \n response phrase = ${response.reasonPhrase}');
    throw response;
  }

  Future<int> getEndpointData(
      {@required String accessToken, @required Endpoints endpoint}) async {
    final uri = api.endpointUri(endpoint);
    final response = await http.get(
      uri.toString(),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final Map<String, dynamic> endpointData = data[0];
        final String responseJsonKey = _responseJsonKeys[endpoint];
        final int result = endpointData[responseJsonKey];
        if (result != null) {
          return result;
        }
      }
    }
    print(
        'Request ${api.tokenUri()} \n status code = ${response.statusCode} \n response phrase = ${response.reasonPhrase}');
    throw response;
  }

  static Map<Endpoints, String> _responseJsonKeys = {
    Endpoints.cases: 'cases',
    Endpoints.casesSuspected: 'data',
    Endpoints.casesConfirmed: 'data',
    Endpoints.deaths: 'data',
    Endpoints.recovered: 'data',
  };
}

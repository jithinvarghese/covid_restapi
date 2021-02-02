import 'package:covid_restapi/app/repositories/endpoints_data.dart';
import 'package:covid_restapi/app/services/api.dart';
import 'package:covid_restapi/app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataRepositry {
  final APIService apiservice;
  String _accessToken;
  DataRepositry({@required this.apiservice});

  Future<int> getEndPointData(Endpoints endpoint) async =>
      await _getRefershToken<int>(
        onGetData: () => apiservice.getEndpointData(
            endpoint: endpoint, accessToken: _accessToken),
      );

  Future<EndpointsData> getAllEndPointData() async =>
      await _getRefershToken<EndpointsData>(
        onGetData: () => _getAllEndpointsData(),
      );
// generic function
  Future<T> _getRefershToken<T>({Future<T> Function() onGetData}) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiservice.getAccessToken();
      }
      return await onGetData();
    } on http.Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiservice.getAccessToken();
        return await onGetData();
      }
      rethrow;
    }
  }

  Future<EndpointsData> _getAllEndpointsData() async {
    final value = await Future.wait([
      apiservice.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoints.cases),
      apiservice.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoints.casesSuspected),
      apiservice.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoints.casesConfirmed),
      apiservice.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoints.deaths),
      apiservice.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoints.recovered),
    ]);
    return EndpointsData(values: {
      Endpoints.cases: value[0],
      Endpoints.casesSuspected: value[1],
      Endpoints.casesConfirmed: value[2],
      Endpoints.deaths: value[3],
      Endpoints.recovered: value[4],
    });
  }
}

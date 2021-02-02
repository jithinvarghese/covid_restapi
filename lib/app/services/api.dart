import 'package:covid_restapi/app/services/api_keys.dart';
import 'package:flutter/material.dart';

enum Endpoints {
  cases,
  casesSuspected,
  casesConfirmed,
  deaths,
  recovered,
}

class API {
  final String apiKey;
  API({@required this.apiKey});

  factory API.sandbox() => API(apiKey: APIKeys.ncovSandboxKey);
  static final String host = 'ncov2019-admin.firebaseapp.com';

  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        path: 'token',
      );
  Uri endpointUri(Endpoints endpoint) => Uri(
        scheme: 'https',
        host: host,
        path: _paths[endpoint],
      );

  static Map<Endpoints, String> _paths = {
    Endpoints.cases: 'cases',
    Endpoints.casesSuspected: 'casesSuspected',
    Endpoints.casesConfirmed: 'casesConfirmed',
    Endpoints.deaths: 'deaths',
    Endpoints.recovered: 'recovered',
  };
}

import 'package:covid_restapi/app/services/api.dart';
import 'package:flutter/material.dart';

class EndpointsData {
  final Map<Endpoints, int> values;
  EndpointsData({@required this.values});

  int get casses => values[Endpoints.cases];
  int get casesSuspected => values[Endpoints.casesSuspected];
  int get casesConfirmed => values[Endpoints.casesConfirmed];
  int get deaths => values[Endpoints.deaths];
  int get recovered => values[Endpoints.recovered];
}

import 'package:covid_restapi/app/services/api.dart';
import 'package:flutter/material.dart';

class EndPointCard extends StatelessWidget {
  final Endpoints endpoint;
  final int value;

  static Map<Endpoints, String> _paths = {
    Endpoints.cases: 'cases',
    Endpoints.casesSuspected: 'casesSuspected',
    Endpoints.casesConfirmed: 'casesConfirmed',
    Endpoints.deaths: 'deaths',
    Endpoints.recovered: 'recovered',
  };

  EndPointCard({this.endpoint, this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_paths[endpoint]),
              Text(value != null ? value.toString() : ''),
            ],
          ),
        ),
      ),
    );
  }
}

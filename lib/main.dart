import 'package:covid_restapi/app/repositories/data_repository.dart';
import 'package:covid_restapi/app/services/api.dart';
import 'package:covid_restapi/app/services/api_service.dart';
import 'package:covid_restapi/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepositry>(
      create: (_) => DataRepositry(
        apiservice: APIService(api: API.sandbox()),
      ),
      child: MaterialApp(
        title: 'Covid Tracker',
        theme: ThemeData.dark(),
        home: Dashboard(),
      ),
    );
  }
}

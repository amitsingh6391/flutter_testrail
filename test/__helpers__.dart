import 'dart:convert';
import 'package:flutter_testrail/flutter_testrail.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as testing;

FlutterTestRail stubTestRailConfig(Map<String, dynamic> sample) {
  return FlutterTestRail.initialize(
    username: 'userName',
    password: 'password',
    serverDomain: 'test.testrail.com',
    client: testing.MockClient((request) async {
      return http.Response(jsonEncode(sample), 200);
    }),
  );
}

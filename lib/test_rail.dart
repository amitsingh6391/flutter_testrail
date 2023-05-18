import 'package:http/http.dart' as http;
import 'flutter_testrail.dart';

class TestRail {
  TestRail._({
    required this.client,
  });
  final TestRailHttpClient client;

  static late TestRail instance;

  static TestRail configure({
    required String password,

    /// The url that points to the TestRail server => https://example.testrail.com
    required String serverDomain,
    required String username,
    http.Client? client,
  }) {
    return instance = TestRail._(
      client: TestRailHttpClient(
        client: client,
        password: password,
        serverDomain: serverDomain,
        username: username,
      ),
    );
  }
}

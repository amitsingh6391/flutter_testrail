import 'package:http/http.dart' as http;
import 'flutter_testrail.dart';

class FlutterTestRail {
  FlutterTestRail._({
    required this.client,
  });
  final FlutterTestRailHttpClient client;

  static late FlutterTestRail instance;

  static FlutterTestRail initialize({
    required String password,

    /// The url that points to the TestRail server => https://example.testrail.com
    required String serverDomain,
    required String username,
    http.Client? client,
  }) {
    return instance = FlutterTestRail._(
      client: FlutterTestRailHttpClient(
        client: client,
        password: password,
        serverDomain: serverDomain,
        username: username,
      ),
    );
  }
}

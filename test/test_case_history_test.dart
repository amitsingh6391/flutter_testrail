import 'package:flutter_testrail/flutter_testrail.dart';
import 'package:flutter_test/flutter_test.dart';
import '__helpers__.dart';
import 'data/sample_test_case.dart';

void main() {
  group('TestCaseHistory', () {
    test('.get', () async {
      stubTestRailConfig(sampleForTestCaseHistory);
      final result = await TestCaseHistory.get(1);
      expect(result.asJson, sampleForTestCaseHistory);
    });
  });
}

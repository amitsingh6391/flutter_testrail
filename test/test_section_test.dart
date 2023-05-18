import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testrail/flutter_testrail.dart';
import '__helpers__.dart';
import 'data/sample_test_section.dart';

void main() {
  group('TestSection', () {
    test('#get', () async {
      stubTestRailConfig(sampleTestSection);
      final result = await TestSection.get(1);

      expect(result.asJson, sampleTestSection);
    });
  });
}

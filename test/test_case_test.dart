import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testrail/flutter_testrail.dart';
import '__helpers__.dart';
import 'data/sample_test_case.dart';

void main() {
  group('TestCase', () {
    test('#create', () async {
      stubTestRailConfig(sampleForNewTestCase);
      final result = await TestCase.create(5598, title: 'Case #2');
      expect(result.asJson, sampleForNewTestCase);
    });

    test('#delete', () async {
      stubTestRailConfig(sampleTestCase);
      final testCase = await TestCase.get(25);
      final result = await testCase.delete();
      expect(result, null);
    });

    test('#delete(soft: true)', () async {
      stubTestRailConfig(sampleTestCase);
      final testCase = await TestCase.get(25);
      stubTestRailConfig(sampleForSoftDeleteCase);
      final result = await testCase.delete(soft: true);
      expect(result?.asJson, sampleForSoftDeleteCase);
    });

    test('#get', () async {
      stubTestRailConfig(sampleTestCase);
      final result = await TestCase.get(1);
      expect(result.asJson, sampleTestCase);
    });

    test('#getAll', () async {
      stubTestRailConfig(sampleForTestCases);
      final result = await TestCase.getAll(1);
      expect(result.asJson, sampleForTestCases);
    });
  });
}

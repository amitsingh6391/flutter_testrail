import 'dart:io';
import 'package:flutter_testrail/flutter_testrail.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  setUpAll(() async {
    TestRailUtil.configureTestRail();
  });

  List<TestStatus> testStatusResults = [
    TestStatus(
      caseId: 1758,
      statusId: 3,
      comment: 'Verify that user is able to see the splash screen',
    ),
    TestStatus(
      caseId: 1759,
      statusId: 3,
      comment:
          'Verify that after splash screen app user is able to see “Permission screen”',
    ),
  ];

  tearDownAll(() async {
    ///  *At the end we will update our test status on TestRail.
    await TestRailUtil.reportMultipleTestCaseResults(testStatusResults);
  });

  group('Test Permission flow', () {
    testWidgets(
      'Grant permissions',
      (tester) async {
        testStatusResults = TestRailUtil.getUpdatdTestStatusList(
          caseId: 1759,
          statusId: 5,
          testStatusResults: testStatusResults,
        );

        /// * Pump Your widget here.
        // tester.pumpWidget(MyApp());

        await tester.pumpAndSettle(const Duration(seconds: 5));

        /// * Find you expected Text here.
        expect(find.text('text'), findsOneWidget);

        await tester.pumpAndSettle();

        /// * Once Your test is passed update your intial test list.
        testStatusResults = TestRailUtil.getUpdatdTestStatusList(
          caseId: 1761,
          statusId: 1,
          testStatusResults: testStatusResults,
        );
      },
    );
  });
}

class TestRailUtil {
  static void configureTestRail() {
    HttpOverrides.global = MyHttpOverrides();
    TestRail.configure(
      username: 'your user name',
      password: 'your password',
      serverDomain: 'https://example.testrail.com',
    );
  }

  /// Add Result Report to Testrail  [reportSingleTestCaseResult],
  ///
  /// And Equivalent Status Code:
  /// 1: Passed
  /// 2: Blocked
  /// 3: Untested (not allowed when adding a new result)
  /// 4: Retest
  /// 5: Failed
  ///
  ///  * So Pass Status Code according to your test status
  static Future<void> reportSingleTestCaseResult({
    required int testCaseId,
    required int testStatusId,
    String? comment,
    String? elapsed,
  }) async {
    final testRun = await TestRun.get(3);
    await testRun.addResultForCase(
      testCaseId,
      statusId: testStatusId,
      comment: comment ?? 'comment',
      elapsed: elapsed,
    );
  }

  /// Add Result Report to Testrail  [reportSingleTestCaseResult],
  ///
  /// And Equivalent Status Code:
  /// 1: Passed
  /// 2: Blocked
  /// 3: Untested (not allowed when adding a new result)
  /// 4: Retest
  /// 5: Failed
  ///
  ///  * So Pass Status Code according to your test status
  static Future<void> reportMultipleTestCaseResults(
    List<TestStatus> testStatusResults,
  ) async {
    final testRun = await TestRun.get(3);
    await testRun.addResultsForCases(
      testStatusResults,
    );
  }

  static List<TestStatus> getUpdatdTestStatusList({
    required List<TestStatus> testStatusResults,
    required int caseId,
    required int statusId,
  }) {
    final updatedTestStatusResults = testStatusResults.map((teststatus) {
      if (teststatus.caseId == caseId) {
        return TestStatus(
          caseId: teststatus.caseId,
          statusId: statusId,
          comment: teststatus.comment,
        );
      }
      return teststatus;
    }).toList();

    return updatedTestStatusResults;
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

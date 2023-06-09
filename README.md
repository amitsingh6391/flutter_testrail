
# Flutter TestRail

This package provides a Dart interface for seamless integration with the TestRail API, enabling automated test reporting, including test run management and case pass/fail reporting.

## Getting Started

Initialize the TestRail instance using the configure method:

```dart
 FlutterTestRail.initialize(
      username: 'your user name',
      password: 'your password',
      /// The url that points to the test rail server => https://example.testrail.com
      serverDomain: 'https://example.testrail.com',
    );
```



<p><a href="https://buymeacoffee.com/amitsingh6391"> <img align="left" src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" height="50" width="210" alt="amitsingh6391" /></a></p><br><br>


## Usage



### Add Result

Adds a new test result, comment or assigns a test. It’s recommended to use 'Add Result' instead if you plan to add results for multiple tests.

```dart

final testResult = await TestResult.addTestResult(9,statusId:1); //replace 9 with your own testId.

```



### Add Results

Adds one or more new test results, comments, or assigns one or more tests. Ideal for test automation to bulk-add multiple test results in one step.


```dart

List<TestStatus> testStatusResult =[TestStatus(caseId:121,statusId:1,comment:'first test passed'),   TestStatus(caseId:122,statusId:5,comment:'second test failed')]

final testResult = await TestResult.addRunResults(3,addTestResults:testStatusResult); //replace 3 with your own RunId.

```




### Add Results For Cases

Adds one or more new test results, comments or assigns one or more tests (using the case IDs). Ideal for test automation to bulk-add multiple test results in one step.


```dart
/// create your intial Test Stauts  list. 
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

  /// Update your list once your test is completed and add status on test rail with updated status.
 await TestRailUtil.reportMultipleTestCaseResults(testStatusResults);

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
  ///  So Pass Status Code according to your test status
  static Future<void> reportMultipleTestCaseResults(
    List<TestStatus> testStatusResults,
  ) async {
    final testRun = await TestRun.get(3); //replace 3 with your own Run Id.
    await testRun.addResultsForCases(
      testStatusResults,
    );
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

```

### Create Test case

```dart
/// Create new test case in section
final createdTestCase = await TestCase.create(
  // Replace with your own sectionId
  1,
  title: 'Test case from API',
  customValues: <String, dynamic>{
    // Custom fields start with "custom_" prefix
    'custom_feedback': 'This is custom feedback',
  },
);
```

### Delete Test case
```dart
/// Get TestCase by ID
final testCase = await TestCase.get(1);

await testCase.delete();
```

### Create or Update Runs

```dart
/// Start by creating a new run
final newRun = await TestRun.create(
  name: 'Test execution',
  projectId: 1,
);

/// Add cases to the run
await newRun.updateRun(
  caseIds: [1, 2, 3, 5],
);
```

Once the run is created, results can be reported by case:

```dart
final result = await newRun.addResultForCase(
  caseId: 1,
  statusId: 1,
);

// Optionally add a screenshot or other image to the result
await result.addAttachment(
  '/workspace/attachments/failure.png',
);
```

### Get

Historical runs, cases, and sections can be retrieved:

```dart
final testCase = await TestCase.get(1);

final testCases = await TestCase.getAll(1);

final testRun = await TestRun.get(1);

final testSection = await TestSection.get(1);

final testCaseHistory = await TestCaseHistory.get(1);
```

Completed or ongoing test run results can be retrieved:

```dart
final caseResults = await TestResult.getCaseResults(
  // Case ID is from TestCases, not TestRun
  184234,
  runId: 1833,
);

final runResults = await TestResult.getRunResults(
  1818,
  statusId: [5, 1],
);

final testResults = await TestResult.getTestResults(
  // Test ID from particular TestRun
  1868150,
);
```
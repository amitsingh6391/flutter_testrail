

# Flutter TestRail

Flutter TestRail is a Dart package that provides a simple and convenient way to interact with the TestRail API for automated test reporting. It allows you to start test runs, report pass/fail status for test cases, and retrieve test run and test case information.

## Getting Started

To get started with Flutter TestRail, you need to configure your TestRail credentials by initializing the TestRail instance:

```dart
TestRail.configure(
  username: 'YOUR_USERNAME',
  password: 'YOUR_PASSWORD',
  serverDomain: 'https://YOUR_TESTRAIL_SERVER.testrail.com',
)


Usage

Creating a Test Case
You can create a new test case in a specific section using the TestCase.create method:

dart
Copy code
final createdTestCase = await TestCase.create(
  sectionId: 1,
  title: 'Test case created via API',
  customValues: <String, dynamic>{
    'custom_feedback': 'This case should be tested last',
  },
);

Deleting a Test Case
To delete a test case, you can use the TestCase.delete method:

dart
Copy code
final testCase = await TestCase.get(1);

await testCase.delete();

Creating or Updating Test Runs
To create a new test run or update an existing one, you can use the TestRun.create and TestRun.updateRun methods:

dart
Copy code
final newRun = await TestRun.create(
  name: 'Test Execution',
  projectId: 1,
);

await newRun.updateRun(
  caseIds: [1, 2, 3, 5],
);

Reporting Test Results
Once you have a test run, you can report results for individual test cases using the TestRun.addResultForCase method:

dart
Copy code
final result = await newRun.addResultForCase(
  caseId: 1,
  statusId: 1,
);

// Optionally add attachments to the result
await result.addAttachment('/path/to/attachment.png');
Retrieving Test Run and Test Case Information
You can retrieve information about test runs and test cases using the following methods:

dart
Copy code
final testCase = await TestCase.get(1);

final testCases = await TestCase.getAll(1);

final testRun = await TestRun.get(1);
Retrieving Test Results
To retrieve test results, you can use the TestResult.getCaseResults, TestResult.getRunResults, and TestResult.getTestResults methods:

dart
Copy code
final caseResults = await TestResult.getCaseResults(
  caseId: 1,
  runId: 2,
);

final runResults = await TestResult.getRunResults(
  runId: 2,
  statusId: [1, 2],
);

final testResults = await TestResult.getTestResults(
  testId: 1,
);


Feel free to explore the package and customize it according to your needs. If you encounter any issues or have questions, please refer to the package documentation or reach out to the package maintainer for support.
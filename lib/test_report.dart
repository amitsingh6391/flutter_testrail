import 'flutter_testrail.dart';

class TestReport {
  TestReport({
    this.id,
    this.name,
    this.description,
    this.notifyUser,
    this.notifyLink,
    this.notifyAttachment,
    this.notifyAttachmentHtmlFormat,
    this.notifyAttachmentPdfFormat,
    this.notifyLinkRecipients,
  });

  int? id;
  String? name;
  String? description;
  bool? notifyUser;
  bool? notifyLink;
  String? notifyLinkRecipients;
  bool? notifyAttachment;
  bool? notifyAttachmentHtmlFormat;
  bool? notifyAttachmentPdfFormat;

  factory TestReport.fromJson(Map<String, dynamic> json) {
    return TestReport(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      notifyUser: json['notify_user'],
      notifyLink: json['notify_link'],
      notifyLinkRecipients: json['notify_link_recipients'],
      notifyAttachment: json['notify_attachment'],
      notifyAttachmentHtmlFormat: json['notify_attachment_html_format'],
      notifyAttachmentPdfFormat: json['notify_attachment_pdf_format'],
    );
  }

  static Future<List<TestReport>?> getReports({required int projectId}) async {
    final reports = await FlutterTestRail.instance.client
        .getReports(endpoint: '/get_reports/$projectId');
    return reports?.map((e) => TestReport.fromJson(e)).toList();
  }

  static Future<void> generateReport({required int reportId}) async {
    await FlutterTestRail.instance.client
        .request('/run_report/$reportId', RequestMethod.get);
  }
}

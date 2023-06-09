import 'flutter_testrail.dart';

class TestRuns {
  final int? limit;
  final Links? links;
  final int? offset;
  final List<TestRun>? runs;
  final int? size;

  TestRuns({
    this.limit,
    this.links,
    this.offset,
    this.runs,
    this.size,
  });

  factory TestRuns.fromJson(Map<String, dynamic> json) {
    final runs =
        json['runs']?.map((r) => TestRun.fromJson(r)).toList().cast<TestRun>();

    return TestRuns(
      limit: json['limit'],
      links: Links.fromJson(json['_links']),
      offset: json['offset'],
      runs: runs,
      size: json['size'],
    );
  }

  Map<String, dynamic> get asJson => {
        'limit': limit,
        '_links': links?.asJson,
        'offset': offset,
        'runs': runs?.map((e) => e.asJson).toList(),
        'size': size,
      };
}

import 'flutter_testrail.dart';

class TestCaseHistory {
  final List<History>? history;
  final int? limit;
  final Links? links;
  final int? offset;
  final int? size;

  TestCaseHistory({
    this.history,
    this.limit,
    this.links,
    this.offset,
    this.size,
  });

  factory TestCaseHistory.fromJson(Map<String, dynamic> json) {
    final history = json['history']
        ?.map((r) => History.fromJson(r))
        .toList()
        .cast<History>();

    return TestCaseHistory(
      history: history,
      limit: json['limit'],
      links: Links.fromJson(json['_links']),
      offset: json['offset'],
      size: json['size'],
    );
  }

  Map<String, dynamic> get asJson => {
        'history': history?.map((e) => e.asJson).toList(),
        'limit': limit,
        '_links': links?.asJson,
        'offset': offset,
        'size': size,
      };

  static Future<TestCaseHistory> get(
    int caseId, {
    int? limit,
    int? offset,
  }) async {
    final response = await FlutterTestRail.instance.client
        .request('/get_history_for_case/$caseId', RequestMethod.get);
    return TestCaseHistory.fromJson(response!);
  }
}

class History {
  // Based on API response list of comments should be included, but wasn't able to determinate how to add comment
  final List<Changes>? changes;
  final DateTime? createdOn;
  final int? id;
  final int? typeId;
  final int? userId;

  History({
    this.changes,
    this.createdOn,
    this.id,
    this.typeId,
    this.userId,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    var createdOn = DateTime.fromMillisecondsSinceEpoch(json['created_on']);

    final changes = json['changes']
        ?.map((c) => Changes.fromJson(c))
        .toList()
        .cast<Changes>();

    return History(
      changes: changes,
      createdOn: createdOn,
      id: json['id'],
      typeId: json['type_id'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> get asJson => {
        'changes': changes?.map((e) => e.asJson).toList(),
        'created_on': createdOn?.millisecondsSinceEpoch,
        'id': id,
        'type_id': typeId,
        'user_id': userId,
      };
}

class Changes {
  final String? field;
  final String? label;
  final String? newText;
  final dynamic newValue;
  final String? oldText;
  final dynamic oldValue;
  final Map<String, dynamic>? options;
  final int? typeId;

  Changes({
    this.field,
    this.label,
    this.newText,
    this.newValue,
    this.oldText,
    this.oldValue,
    this.options,
    this.typeId,
  });

  factory Changes.fromJson(Map<String, dynamic> json) {
    return Changes(
      field: json['field'],
      label: json['label'],
      newText: json['new_text'],
      newValue: json['new_value'],
      oldText: json['old_text'],
      oldValue: json['old_value'],
      options: json['options'],
      typeId: json['type_id'],
    );
  }

  Map<String, dynamic> get asJson => {
        'field': field,
        if (label != null) 'label': label,
        'new_text': newText,
        'new_value': newValue,
        'old_text': oldText,
        'old_value': oldValue,
        if (options != null) 'options': options,
        'type_id': typeId,
      };
}

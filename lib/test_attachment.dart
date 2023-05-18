class TestAttachment {
  const TestAttachment({required this.id});
  final int id;

  factory TestAttachment.fromJson(Map<String, dynamic> json) {
    return TestAttachment(id: json['attachment_id']);
  }

  Map<String, dynamic> get asJson => {
        'attachment_id': id,
      };
}

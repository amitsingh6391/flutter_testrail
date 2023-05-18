class Links {
  const Links({
    this.next,
    this.prev,
  });
  final String? next;
  final String? prev;

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      next: json['next'],
      prev: json['prev'],
    );
  }

  Map<String, dynamic> get asJson => {'next': next, 'prev': prev};
}

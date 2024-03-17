class ResultModul {
  ResultModul({
    required this.status,
    required this.result,
  });
  late final bool status;
  late final String result;

  ResultModul.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result;
    return _data;
  }
}

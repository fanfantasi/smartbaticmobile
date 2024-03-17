class ReadModul {
  ReadModul({
    required this.status,
    required this.data,
    required this.result,
  });
  late final bool status;
  late final int data;
  late final String result;

  ReadModul.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data;
    _data['result'] = result;
    return _data;
  }
}

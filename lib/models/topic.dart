class TopicModel {
  TopicModel({
    required this.status,
    required this.result,
  });
  late final bool status;
  late final List<ResultTopic> result;

  TopicModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        List.from(json['result']).map((e) => ResultTopic.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ResultTopic {
  ResultTopic({
    required this.id,
    required this.thema,
    required this.date,
    required this.active,
    required this.batch,
  });
  late final int id;
  late final String thema;
  late final String date;
  late final int active;
  late final int batch;

  ResultTopic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thema = json['thema'];
    date = json['date'];
    active = json['active'];
    batch = json['batch'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['thema'] = thema;
    _data['date'] = date;
    _data['active'] = active;
    _data['batch'] = batch;
    return _data;
  }
}

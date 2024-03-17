class ModulesModel {
  ModulesModel({
    required this.status,
    required this.result,
  });
  late final bool status;
  late final List<ResultModules> result;

  ModulesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = List.from(json['result'])
        .map((e) => ResultModules.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ResultModules {
  ResultModules({
    required this.id,
    required this.title,
    required this.batch,
    required this.date,
    required this.read,
    required this.file,
  });
  late final int id;
  late final String title;
  late final int batch;
  late final String date;
  late final int read;
  late final String file;

  ResultModules.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    batch = json['batch'];
    date = json['date'];
    read = json['read'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['batch'] = batch;
    _data['date'] = date;
    _data['read'] = read;
    _data['file'] = file;
    return _data;
  }
}

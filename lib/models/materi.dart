class MateriModel {
  MateriModel({
    required this.status,
    required this.result,
  });
  late final bool status;
  late final List<ResultMateri> result;

  MateriModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        List.from(json['result']).map((e) => ResultMateri.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ResultMateri {
  ResultMateri({
    required this.id,
    required this.materi,
  });
  late final int id;
  late final String materi;

  ResultMateri.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    materi = json['materi'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['materi'] = materi;
    return _data;
  }
}

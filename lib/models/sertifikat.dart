class SertifikatModul {
  SertifikatModul({
    required this.status,
    required this.result,
  });
  late final bool status;
  late final List<ResultSertifikat> result;

  SertifikatModul.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = List.from(json['result'])
        .map((e) => ResultSertifikat.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ResultSertifikat {
  ResultSertifikat({
    required this.uid,
    required this.sertifikat,
  });
  late final String uid;
  late final String sertifikat;

  ResultSertifikat.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    sertifikat = json['sertifikat'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uid'] = uid;
    _data['sertifikat'] = sertifikat;
    return _data;
  }
}

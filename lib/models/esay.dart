class EsayModel {
  EsayModel({
    required this.status,
    required this.result,
  });
  late final bool status;
  late final List<ResultEsay> result;

  EsayModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        List.from(json['result']).map((e) => ResultEsay.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ResultEsay {
  ResultEsay({required this.id, required this.question, required this.answer});
  late final int id;
  late final String question;
  late final String answer;

  ResultEsay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['question'] = question;
    _data['answer'] = answer;
    return _data;
  }
}

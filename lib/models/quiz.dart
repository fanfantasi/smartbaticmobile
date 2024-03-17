class QuizModel {
  QuizModel({
    required this.status,
    required this.result,
  });
  late final bool status;
  late final List<ResultQuiz> result;

  QuizModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        List.from(json['result']).map((e) => ResultQuiz.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ResultQuiz {
  ResultQuiz({
    required this.id,
    required this.question,
    required this.answer,
    required this.opt,
  });
  late final int id;
  late final String question;
  late final String answer;
  late final List<String> opt;

  ResultQuiz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    opt = List.castFrom<dynamic, String>(json['opt']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['question'] = question;
    _data['answer'] = answer;
    _data['opt'] = opt;
    return _data;
  }
}

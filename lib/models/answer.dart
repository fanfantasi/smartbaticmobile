class AnswerModul {
  AnswerModul({
    required this.status,
    required this.result,
  });
  late final bool status;
  late final List<ResultAnswer> result;

  AnswerModul.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        List.from(json['result']).map((e) => ResultAnswer.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ResultAnswer {
  ResultAnswer({
    required this.id,
    required this.quiz,
    required this.correct,
    required this.incorrect,
    required this.date,
  });
  late final int id;
  late final int quiz;
  late final int correct;
  late final int incorrect;
  late final String date;

  ResultAnswer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quiz = json['quiz'];
    correct = json['correct'];
    incorrect = json['incorrect'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['quiz'] = quiz;
    _data['correct'] = correct;
    _data['incorrect'] = incorrect;
    _data['date'] = date;
    return _data;
  }
}

class AnswerEsayModul {
  AnswerEsayModul({
    required this.status,
    required this.result,
  });
  late final bool status;
  late final List<ResultAnswerEsay> result;

  AnswerEsayModul.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = List.from(json['result'])
        .map((e) => ResultAnswerEsay.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ResultAnswerEsay {
  ResultAnswerEsay({
    required this.id,
    required this.question,
    required this.answer,
    required this.correct,
    required this.date,
  });
  late final int id;
  late final String question;
  late final String answer;
  late final String correct;
  late final String date;

  ResultAnswerEsay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    correct = json['correct'].toString();
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['question'] = question;
    _data['answer'] = answer;
    _data['correct'] = correct.toString();
    _data['date'] = date;
    return _data;
  }
}

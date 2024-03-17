import 'package:chat_apps/constanta/string.dart';
import 'package:chat_apps/models/quiz.dart';
import 'package:chat_apps/pages/more/more_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:get/get.dart';

import 'quiz_controller.dart';

class QuizDetailPage extends StatefulWidget {
  const QuizDetailPage({Key? key}) : super(key: key);

  @override
  _QuizDetailPageState createState() => _QuizDetailPageState();
}

class _QuizDetailPageState extends State<QuizDetailPage> {
  QuizController quizController = Get.put(QuizController());
  MoreController moreController = Get.put(MoreController());

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final TextStyle _questionStyle = const TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white);

  int _currentIndex = 0;
  final Map<int, dynamic> _answers = {};

  @override
  Widget build(BuildContext context) {
    ResultQuiz question = quizController.resultQuiz[_currentIndex];
    final List<dynamic> options = question.opt;
    if (!options.contains(question.answer)) {
      options.add(question.opt);
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text(
            Get.arguments[0],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          elevation: 0,
        ),
        body: Stack(
          children: [
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                decoration: const BoxDecoration(color: kPrimaryColor),
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Text(
                          "${_currentIndex + 1}",
                          style: MediaQuery.of(context).size.width > 800
                              ? _questionStyle.copyWith(fontSize: 30.0)
                              : _questionStyle,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Text(
                          HtmlUnescape().convert(quizController
                              .resultQuiz[_currentIndex].question),
                          softWrap: true,
                          style: MediaQuery.of(context).size.width > 800
                              ? _questionStyle.copyWith(fontSize: 30.0)
                              : _questionStyle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ...options.map((option) => RadioListTile<String>(
                              title: Text(
                                HtmlUnescape().convert("$option"),
                                style: MediaQuery.of(context).size.width > 800
                                    ? const TextStyle(fontSize: 30.0)
                                    : null,
                              ),
                              activeColor: kPrimaryColor,
                              groupValue: _answers[_currentIndex],
                              value: option,
                              onChanged: (value) {
                                setState(() {
                                  _answers[_currentIndex] = option;
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: OutlinedButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                              _currentIndex ==
                                      (quizController.resultQuiz.length - 1)
                                  ? "Selesai"
                                  : "Lanjutkan",
                              style: const TextStyle(color: Colors.white)),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: _nextSubmit,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _nextSubmit() async {
    if (_answers[_currentIndex] == null) {
      Get.snackbar('info', 'Anda harus memilih jawaban anda untuk melanjutkan',
          colorText: Colors.black54,
          backgroundColor: kPrimaryColor.withOpacity(0.3),
          margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          titleText: const Text(
            'Informasi',
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ));
      return;
    }
    if (_currentIndex < (quizController.resultQuiz.length - 1)) {
      setState(() {
        _currentIndex++;
      });
    } else {
      int correct = 0;
      _answers.forEach((index, value) {
        if (quizController.resultQuiz[index].answer == value) {
          correct++;
        }
      });
      bool result = await quizController.submitquiz(
          uid: moreController.usersModel.uid,
          topicid: Get.arguments[1],
          quiz: quizController.resultQuiz.length,
          corret: correct,
          incorret: quizController.resultQuiz.length - correct);
      if (result) {
        await quizController.fetchAnswer(
            uid: moreController.usersModel.uid,
            topicid: Get.arguments[1].toString());
        Get.offAndToNamed('/quizfinish', arguments: Get.arguments[1]);
      } else {
        Get.snackbar('error', 'Sepertinya Jaringan Anda Kurang Stabil',
            colorText: Colors.black54,
            backgroundColor: kPrimaryColor.withOpacity(0.3),
            margin:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            titleText: const Text(
              'Informasi',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ));
      }
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text(
                    "Anda yakin ingin keluar dari Soal Latihan? Semua jawaban Anda akan hilang."),
                title: const Text("Peringatan!"),
                actions: <Widget>[
                  OutlinedButton(
                    child: const Text(
                      "Ya",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      side: const BorderSide(
                          color: kPrimaryColor,
                          style: BorderStyle.solid,
                          width: 0.5),
                    ),
                  ),
                  OutlinedButton(
                    child: const Text("Tidak"),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                ],
              );
            })) ??
        false;
  }
}

import 'package:chat_apps/constanta/string.dart';
import 'package:chat_apps/pages/more/more_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'quiz_controller.dart';

class QuizFinishPage extends StatefulWidget {
  const QuizFinishPage({Key? key}) : super(key: key);

  @override
  _QuizFinishPageState createState() => _QuizFinishPageState();
}

class _QuizFinishPageState extends State<QuizFinishPage> {
  QuizController quizController = Get.put(QuizController());
  MoreController moreController = Get.find<MoreController>();
  // late final List<ResultQuiz> questions;
  // late final Map<int, dynamic> answers;

  @override
  void initState() {
    super.initState();

    quizController.fecthtopic(
        batch: moreController.usersModel.batch,
        jenjang: moreController.usersModel.jenjang,
        uid: moreController.usersModel.uid);
  }

  @override
  Widget build(BuildContext context) {
    late TextStyle titleStyle = const TextStyle(
        color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.w500);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hasil Jawaban'),
          elevation: 0,
        ),
        body: Obx(
          () => (quizController.proccess.value)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    kPrimaryColor,
                    kPrimaryLightColor,
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            title:
                                Text("Total Soal Latihan", style: titleStyle),
                            trailing: Text(
                                "${quizController.resultAnswer.quiz}",
                                style: const TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            title: Text("Nilai", style: titleStyle),
                            trailing: Text(
                                "${(quizController.resultAnswer.correct / quizController.resultAnswer.quiz * 100).round()}",
                                style: const TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            title: Text("Jawaban benar", style: titleStyle),
                            trailing: Text(
                                "${quizController.resultAnswer.correct} dari ${quizController.resultAnswer.quiz}",
                                style: const TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            title: Text("Jawaban Salah", style: titleStyle),
                            trailing: Text(
                                "${quizController.resultAnswer.incorrect} dari ${quizController.resultAnswer.quiz}",
                                style: const TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            OutlinedButton(
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: Text(
                                  "Kembali",
                                  style: TextStyle(
                                      color: kPrimaryLightColor,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                shape: const StadiumBorder(),
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
        ));
  }
}

import 'dart:io';
import 'package:chat_apps/constanta/string.dart';
import 'package:chat_apps/pages/materi/widgets/quiz/quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizOptionsDialog extends StatefulWidget {
  final String? title;
  final int? topicid;
  const QuizOptionsDialog({Key? key, this.title, this.topicid})
      : super(key: key);

  @override
  _QuizOptionsDialogState createState() => _QuizOptionsDialogState();
}

class _QuizOptionsDialogState extends State<QuizOptionsDialog> {
  QuizController quizController = Get.put(QuizController());
  late bool processing;

  @override
  void initState() {
    super.initState();
    processing = false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey.shade200,
            child: Text("Soal Latihan",
                style: Theme.of(context).textTheme.bodyText1),
          ),
          const SizedBox(height: 10.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Tentang :",
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(widget.title!,
                style: Theme.of(context).textTheme.bodyText1),
          ),
          const SizedBox(height: 20.0),
          Obx(
            () => (quizController.proccess.value)
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: OutlinedButton(
                        onPressed: () {
                          _startQuiz();
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.menu_book_rounded,
                              size: 24,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            Text(
                              'Mulai',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          side: const BorderSide(
                              color: kPrimaryColor,
                              style: BorderStyle.solid,
                              width: 0.5),
                        ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  void _startQuiz() async {
    try {
      await quizController.fetchquizbytopic(topicid: widget.topicid);
      Navigator.pop(context);
      if (quizController.resultQuiz.isEmpty) {
        Get.snackbar(
            'error', 'Soal Latihan Belum Siap, \nSilahkan kembali lagi nanti.',
            colorText: Colors.black54,
            backgroundColor: kPrimaryColor.withOpacity(0.3),
            margin:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            titleText: const Text(
              'Error',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ));
        return;
      }
      Get.toNamed('/quizdetail', arguments: [widget.title, widget.topicid]);
    } on SocketException catch (_) {
      Get.snackbar('error',
          'Tidak dapat menjangkau server, \n Harap periksa koneksi internet Anda.',
          colorText: Colors.black54,
          backgroundColor: kPrimaryColor.withOpacity(0.3),
          margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          titleText: const Text(
            'Error',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ));
    } catch (e) {
      Get.snackbar(
          'error', 'Kesalahan tak terduga saat mencoba menyambung ke Server',
          colorText: Colors.black54,
          backgroundColor: kPrimaryColor.withOpacity(0.3),
          margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          titleText: const Text(
            'Error',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ));
    }
  }
}

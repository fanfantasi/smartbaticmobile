import 'package:chat_apps/constanta/string.dart';
import 'package:chat_apps/models/esay.dart';
import 'package:chat_apps/pages/more/more_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:get/get.dart';

import 'esay_controller.dart';

class EsayDetailPage extends StatefulWidget {
  const EsayDetailPage({Key? key}) : super(key: key);

  @override
  _EsayDetailPageState createState() => _EsayDetailPageState();
}

class _EsayDetailPageState extends State<EsayDetailPage> {
  EsayController esayController = Get.put(EsayController());
  MoreController moreController = Get.put(MoreController());

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final TextStyle _questionStyle = const TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white);

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    esayController.answerController.clear();
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
                          HtmlUnescape().convert(esayController
                              .resultEsay[_currentIndex].question),
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
                    child: Container(
                      margin: const EdgeInsets.only(top: 18.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        autofocus: true,
                        maxLines: null,
                        style: const TextStyle(color: Colors.grey),
                        controller: esayController.answerController,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: 'Jawaban',
                          labelStyle: TextStyle(fontSize: 14.0),
                          contentPadding: EdgeInsets.all(8.0),
                          border: InputBorder.none,
                        ),
                      ),
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
                                      (esayController.resultEsay.length - 1)
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
    if (esayController.answerController.text == '') {
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
    if (_currentIndex < (esayController.resultEsay.length - 1)) {
      esayController.resultEsay[_currentIndex] = ResultEsay(
          id: esayController.resultEsay[_currentIndex].id,
          question: esayController.resultEsay[_currentIndex].question,
          answer: esayController.answerController.text);
      esayController.answerController.clear();
      setState(() {
        _currentIndex++;
      });
    } else {
      esayController.resultEsay[_currentIndex] = ResultEsay(
          id: esayController.resultEsay[_currentIndex].id,
          question: esayController.resultEsay[_currentIndex].question,
          answer: esayController.answerController.text);
      bool result = await esayController.submitquiz(
          uid: moreController.usersModel.uid, topicid: Get.arguments[1]);
      if (result) {
        Get.offAndToNamed('/esayfinish', arguments: Get.arguments[1]);
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
                content:
                    const Text("Anda yakin ingin keluar dari Soal Latihan?."),
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

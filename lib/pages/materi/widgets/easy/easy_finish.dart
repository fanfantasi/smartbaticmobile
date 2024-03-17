import 'package:chat_apps/constanta/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'esay_controller.dart';

class EsayFinishPage extends StatefulWidget {
  const EsayFinishPage({Key? key}) : super(key: key);

  @override
  _EsayFinishPageState createState() => _EsayFinishPageState();
}

class _EsayFinishPageState extends State<EsayFinishPage> {
  EsayController esayController = Get.put(EsayController());

  @override
  void initState() {
    super.initState();
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
      body: Container(
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
                  title: Text("Total Soal Latihan", style: titleStyle),
                  trailing: Text("${esayController.resultAnswer.length}",
                      style: const TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 10.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: esayController.resultAnswer.length,
                itemBuilder: (context, i) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      leading: CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Text(
                          "${i + 1}",
                        ),
                      ),
                      title: Text(
                        esayController.resultAnswer[i].question,
                        style: const TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            esayController.resultAnswer[i].answer,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Nilai Perolehan'),
                              Text(
                                esayController.resultAnswer[i].correct,
                                style: const TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10.0),
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
    );
  }
}

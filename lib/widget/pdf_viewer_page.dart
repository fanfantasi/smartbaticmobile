import 'dart:io';

import 'package:chat_apps/widget/pdf_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';

class PDFViewerPage extends StatefulWidget {
  const PDFViewerPage({Key? key}) : super(key: key);

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  PDFViewController? controller;
  int? pages = 0;
  int? indexPage = 0;
  bool isReady = false;
  String errorMessage = '';
  File? file;
  @override
  void initState() {
    readpdf();
    secureScreen();

    super.initState();
  }

  void readpdf() async {
    file = await PDFApi.loadNetwork(Get.arguments[1]);
    if (file != null) {
      setState(() {
        isReady = !isReady;
      });
    }
  }

  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  Widget build(BuildContext context) {
    final text = '${indexPage! + 1} of $pages';

    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: const Text('Sertifikat'),
        actions: pages! >= 2
            ? [
                Center(
                    child: Text(
                  text,
                  style: const TextStyle(color: Colors.white),
                )),
                IconButton(
                  icon: const Icon(Icons.chevron_left, size: 32),
                  onPressed: () {
                    final page = indexPage == 0 ? pages : indexPage! - 1;
                    controller!.setPage(page!);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, size: 32),
                  onPressed: () {
                    final page = indexPage == pages! - 1 ? 0 : indexPage! + 1;
                    controller!.setPage(page);
                  },
                ),
              ]
            : null,
      ),
      body: (!isReady)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(children: [
              PDFView(
                filePath: file!.path,
                enableSwipe: true,
                swipeHorizontal: true,
                autoSpacing: false,
                pageFling: false,
                onRender: (pages) => setState(() {
                  this.pages = pages;
                  isReady = true;
                }),
                onError: (error) {
                  setState(() {
                    errorMessage =
                        'Sertifikat Baru Selesai di Buat, Silahkan kembali, dan pilih menu sertifikat lagi';
                  });
                },
                onPageError: (page, error) {
                  setState(() {
                    errorMessage =
                        'Sertifikat Baru Selesai di Buat, Silahkan kembali, dan pilih menu sertifikat lagi';
                  });
                },
                onViewCreated: (controller) =>
                    setState(() => this.controller = controller),
                onPageChanged: (indexPage, _) =>
                    setState(() => this.indexPage = indexPage),
              ),
              errorMessage.isEmpty
                  ? !isReady
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container()
                  : Center(
                      child: Text(
                        errorMessage,
                        textAlign: TextAlign.center,
                      ),
                    )
            ]),
    );
  }
}

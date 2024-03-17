import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:chat_apps/pages/error/inactive.dart';
import 'package:chat_apps/pages/more/more_controller.dart';
import 'package:chat_apps/pages/sertifikat/sertifikat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SertifikatPage extends StatefulWidget {
  const SertifikatPage({Key? key}) : super(key: key);

  @override
  _SertifikatPageState createState() => _SertifikatPageState();
}

class _SertifikatPageState extends State<SertifikatPage> {
  MoreController moreController = Get.put(MoreController());
  SertifikatController sertifikatController = Get.put(SertifikatController());

  bool _isLoading = true;
  PDFDocument document = PDFDocument();

  @override
  void initState() {
    super.initState();
    fetchSertifikat().then((value) {
      if (value) {
        loadDocument();
      }
    });
  }

  loadDocument() async {
    document = await PDFDocument.fromURL(
        sertifikatController.resultSertifikat[0].sertifikat);

    setState(() => _isLoading = false);
  }

  Future<bool> fetchSertifikat() async {
    await sertifikatController.fetchSertifikat(
        uid: moreController.usersModel.uid);
    if (sertifikatController.resultSertifikat.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sertifikat'),
      ),
      body: Obx(() => (moreController.isActive.value)
          ? Obx(
              () => (sertifikatController.proccess.value)
                  ? const Center(child: CircularProgressIndicator())
                  : Center(
                      child: (sertifikatController.resultSertifikat.isEmpty)
                          ? const Center(
                              child: Text('Sertifikat Belum Tersedia'),
                            )
                          : _isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : PDFViewer(
                                  document: document,
                                  zoomSteps: 1,
                                  showPicker: false,
                                  showNavigation: true,
                                ),
                    ),
            )
          : const InactivePage()),
    );
  }
}

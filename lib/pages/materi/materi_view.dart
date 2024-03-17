import 'package:chat_apps/constanta/string.dart';
import 'package:chat_apps/pages/materi/materi_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MateriPage extends StatefulWidget {
  const MateriPage({Key? key}) : super(key: key);

  @override
  State<MateriPage> createState() => _MateriPageState();
}

class _MateriPageState extends State<MateriPage> {
  MateriController materiController = Get.put(MateriController());

  // @override
  // void initState() {
  //   getMateri();
  //   super.initState();
  // }

  // getMateri() async {
  //   await materiController.fecthmateri();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Materi Smart Batik Class'),
      ),
      body: Obx(() {
        return materiController.loading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  height: 12,
                  color: Colors.blue.withOpacity(.2),
                  indent: 16,
                  endIndent: 16,
                ),
                itemCount: materiController.resultMateris.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    leading: CircleAvatar(
                      maxRadius: 24,
                      backgroundColor: Colors.blue.withOpacity(.1),
                      child: Image.asset(
                        'assets/icons/ic-books.png',
                        width: 24,
                        height: 24,
                        color: kPrimaryColor,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    title: Text(
                      materiController.resultMateris[i].materi,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                    onTap: () {
                      materiController.resultMateri =
                          materiController.resultMateris[i];
                      materiController.activeMenu.value = 0;
                      Get.toNamed('/materibar');
                    },
                  );
                },
              );
      }),
    );
  }
}

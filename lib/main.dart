import 'package:chat_apps/services/firebase_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/error/notfound.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ChatApps',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      unknownRoute:
          GetPage(name: '/notfound', page: () => const UnknownRoutePage()),
      initialRoute: AppRoutes.splashScreen,
      getPages: AppPages.list,
    );
  }
}

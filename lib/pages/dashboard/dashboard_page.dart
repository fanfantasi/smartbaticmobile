import 'package:chat_apps/constanta/string.dart';
import 'package:chat_apps/pages/home/home.dart';
import 'package:chat_apps/pages/materi/materi_view.dart';
import 'package:chat_apps/pages/more/more.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dashboard_controller.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final key = GlobalKey();
  int activeMenu = 0;
  onMenuTapped(index) {
    setState(() => activeMenu = index);
  }

  Widget activeScreen() {
    switch (activeMenu) {
      case 0:
        return const HomePage();
      case 1:
        return const MateriPage();
      case 2:
        return const MorePage();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return WillPopScope(
          key: key,
          onWillPop: controller.onWillPop,
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.white,
            ),
            child: Scaffold(
                body: activeScreen(),
                bottomNavigationBar: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: kPrimaryColor,
                    backgroundColor: Colors.white,
                    unselectedItemColor: Colors.black,
                    selectedLabelStyle: const TextStyle(fontSize: 12),
                    unselectedLabelStyle: const TextStyle(fontSize: 12),
                    elevation: 0,
                    currentIndex: activeMenu,
                    onTap: onMenuTapped,
                    items: [
                      BottomNavigationBarItem(
                        icon: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Image.asset(
                            'assets/icons/ic-home.png',
                            width: 24,
                            height: 24,
                            color: activeMenu == 0
                                ? kPrimaryColor
                                : const Color(0xFF626B79),
                          ),
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                          icon: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Image.asset(
                              'assets/icons/ic-books.png',
                              width: 24,
                              height: 24,
                              color: activeMenu == 1
                                  ? kPrimaryColor
                                  : const Color(0xFF626B79),
                            ),
                          ),
                          label: 'Materi'),
                      BottomNavigationBarItem(
                          icon: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Image.asset(
                              'assets/icons/ic-more.png',
                              width: 24,
                              height: 24,
                              color: activeMenu == 3
                                  ? kPrimaryColor
                                  : const Color(0xFF626B79),
                            ),
                          ),
                          label: 'More'),
                    ])),
          ),
        );
      },
    );
  }
}

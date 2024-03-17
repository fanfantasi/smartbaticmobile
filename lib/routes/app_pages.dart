import 'package:chat_apps/pages/auth/signup.dart';
import 'package:chat_apps/pages/dashboard/dashboard_binding.dart';
import 'package:chat_apps/pages/dashboard/dashboard_page.dart';
import 'package:chat_apps/pages/error/inactive.dart';
import 'package:chat_apps/pages/home/pdf_viwer.dart';
import 'package:chat_apps/pages/materi/widgets/easy/easy_finish.dart';
import 'package:chat_apps/pages/materi/widgets/easy/esay_detail.dart';
import 'package:chat_apps/pages/materi/widgets/eksperimen/uploadphoto.dart';
import 'package:chat_apps/pages/materi/widgets/materibar.dart';
import 'package:chat_apps/pages/materi/widgets/quiz/quiz_detail.dart';
import 'package:chat_apps/pages/materi/widgets/quiz/quiz_finish.dart';
import 'package:chat_apps/pages/materi/widgets/videos/youtube.dart';
import 'package:chat_apps/pages/portfolio/portfolioguru.dart';
import 'package:chat_apps/pages/portfolio/portfoliosiswa.dart';
import 'package:chat_apps/pages/portfolio/uploadphoto.dart';
import 'package:chat_apps/pages/profil/profil.dart';
import 'package:chat_apps/pages/sertifikat/sertifikat.dart';
import 'package:chat_apps/pages/splashscreen/splashscreen.dart';
import 'package:chat_apps/widget/pdf_viewer_page.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(name: AppRoutes.splashScreen, page: () => const SplashScreenPage()),
    GetPage(
        name: AppRoutes.home,
        page: () => const DashboardPage(),
        binding: DashboardBinding()),
    GetPage(
        name: AppRoutes.auth,
        page: () => const SignupPage(),
        transition: Transition.native),
    GetPage(
        name: AppRoutes.inactive,
        page: () => const InactivePage(),
        transition: Transition.native),
    GetPage(
        name: AppRoutes.viewpdf,
        page: () => const PDFViewerPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.pdfviwer,
        page: () => const PdfPage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.youtube,
        page: () => const YoutubePage(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.quizdetail,
        page: () => const QuizDetailPage(),
        transition: Transition.native),
    GetPage(
        name: AppRoutes.esaydetail,
        page: () => const EsayDetailPage(),
        transition: Transition.native),
    GetPage(
        name: AppRoutes.quizfinish,
        page: () => const QuizFinishPage(),
        transition: Transition.native),
    GetPage(
        name: AppRoutes.esayfinish,
        page: () => const EsayFinishPage(),
        transition: Transition.native),
    GetPage(
        name: AppRoutes.profil,
        page: () => const ProfilPage(),
        transition: Transition.native),
    GetPage(
        name: AppRoutes.portfoliosiswa,
        page: () => const PortfolioSiswaPage(),
        transition: Transition.native),
    GetPage(
        name: AppRoutes.portfolioguru,
        page: () => const PortfolioGuruPage(),
        transition: Transition.native),
    GetPage(
        name: AppRoutes.sertifikat,
        page: () => const SertifikatPage(),
        transition: Transition.native),
    GetPage(
        name: AppRoutes.uploadphoto,
        page: () => const UploadPhotoPage(),
        transition: Transition.native),
    GetPage(
        name: AppRoutes.uploadeksperimen,
        page: () => const UploadEksperimenPage(),
        transition: Transition.native),
    GetPage(
        name: AppRoutes.materibar,
        page: () => const MateriBar(),
        transition: Transition.native),
  ];
}

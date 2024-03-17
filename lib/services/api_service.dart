import 'package:chat_apps/constanta/string.dart';
import 'package:chat_apps/models/answer.dart';
import 'package:chat_apps/models/answeresay.dart';
import 'package:chat_apps/models/banners.dart';
import 'package:chat_apps/models/esay.dart';
import 'package:chat_apps/models/gallery.dart';
import 'package:chat_apps/models/materi.dart';
import 'package:chat_apps/models/modules.dart';
import 'package:chat_apps/models/quiz.dart';
import 'package:chat_apps/models/read.dart';
import 'package:chat_apps/models/result.dart';
import 'package:chat_apps/models/sertifikat.dart';
import 'package:chat_apps/models/topic.dart';
import 'package:chat_apps/models/users.dart';
import 'package:chat_apps/models/videos.dart';
import 'package:dio/dio.dart';

class ApiService {
  var dio = Dio();

  ApiService() {
    // ignore: unnecessary_null_comparison
    if (dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: AppString.baseurl,
        receiveDataWhenStatusError: true,
        connectTimeout: 10 * 1000, // 30 seconds
        receiveTimeout: 10 * 1000, // 30 seconds
      );
      dio = Dio(options);
    }
  }

  Future<ResultModul> addorupdate({uid, email, displayname, avatar}) async {
    try {
      final response = await Dio()
          .post(AppString.baseurl + "api/user/addorupdate", data: {
        'uid': uid,
        'email': email,
        'displayname': displayname,
        'avatar': avatar
      });
      if (response.statusCode == 200) {
        return ResultModul.fromJson(response.data);
      } else {
        throw Failure("Failled to Register");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }

  Future<ResultModul> updateprofile(
      {uid, displayname, jurusan, userid, avatar, photourl}) async {
    try {
      FormData formData;
      String url = '';
      if (avatar != null) {
        String fileName = avatar.split('/').last;
        formData = FormData.fromMap({
          'jurusan': jurusan,
          'displayname': displayname,
          'userid': userid,
          'photo': await MultipartFile.fromFile(avatar, filename: fileName),
        });
        url = AppString.baseurl + "api/user/avatar/" + uid;
      } else {
        formData = FormData.fromMap({
          'jurusan': jurusan,
          'displayname': displayname,
          'userid': userid,
        });
        url = AppString.baseurl + "api/user/" + uid;
      }
      final response = await Dio().post(url, data: formData);
      if (response.statusCode == 200) {
        return ResultModul.fromJson(response.data);
      } else {
        throw Failure("Failled to Register");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }

  Future<UserModel> checkLogin({String? uid}) async {
    try {
      final response = await Dio().get(AppString.baseurl + "api/user/" + uid!);
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Failure("Failled to Log In");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }

  Future<BannersModel> fetchBanners() async {
    try {
      final response = await Dio().get(AppString.baseurl + "api/banners");
      if (response.statusCode == 200) {
        return BannersModel.fromJson(response.data);
      } else {
        throw Failure("Failled to Banners");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }

  Future<ModulesModel> fetchModules({int? batch, String? jenjang}) async {
    try {
      final response = await Dio().post(AppString.baseurl + "api/modules",
          data: {'batch': batch, 'jenjang': jenjang});
      if (response.statusCode == 200) {
        return ModulesModel.fromJson(response.data);
      } else {
        throw Failure("Failled to Modules Pembelajaran");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }

  Future<VideosModel> fetchVideos({String? materiid}) async {
    try {
      final response =
          await Dio().get(AppString.baseurl + "api/videos/" + materiid!);
      if (response.statusCode == 200) {
        return VideosModel.fromJson(response.data);
      } else {
        throw Failure("Failled to Modules Videos");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }

  Future<TopicModel> fetchTopic(
      {int? batch, String? jenjang, String? uid, String? materiid}) async {
    try {
      final response = await Dio().post(
          AppString.baseurl + "api/topic/" + materiid!,
          data: {'batch': batch, 'jenjang': jenjang, 'uid': uid});
      if (response.statusCode == 200) {
        return TopicModel.fromJson(response.data);
      } else {
        throw Failure("Failled to Topic Quiz");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }

  Future<TopicModel> fetchTopicEsay(
      {int? batch, String? jenjang, String? uid, String? materiid}) async {
    try {
      final response = await Dio().post(
          AppString.baseurl + "api/topic/esay/" + materiid!,
          data: {'batch': batch, 'jenjang': jenjang, 'uid': uid});
      if (response.statusCode == 200) {
        return TopicModel.fromJson(response.data);
      } else {
        throw Failure("Failled to Topic Quiz");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }

  Future<QuizModel> fetchQuizByTopic({int? topicid}) async {
    try {
      final response = await Dio()
          .post(AppString.baseurl + "api/quiz", data: {'topicid': topicid});
      if (response.statusCode == 200) {
        return QuizModel.fromJson(response.data);
      } else {
        throw Failure("Failled to Quiz");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }

  Future<EsayModel> fetchEsayByTopic({int? topicid}) async {
    try {
      final response = await Dio()
          .post(AppString.baseurl + "api/esay", data: {'topicid': topicid});
      if (response.statusCode == 200) {
        return EsayModel.fromJson(response.data);
      } else {
        throw Failure("Failled to Quiz");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }

  Future<ReadModul> postReadModule({id}) async {
    try {
      final response = await Dio()
          .post(AppString.baseurl + "api/modules/read", data: {'moduleid': id});
      if (response.statusCode == 200) {
        return ReadModul.fromJson(response.data);
      } else {
        throw Failure("Failled to Module");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }

  Future<ReadModul> postReadVideo({id}) async {
    try {
      final response = await Dio()
          .post(AppString.baseurl + "api/videos/read", data: {'videoid': id});
      if (response.statusCode == 200) {
        return ReadModul.fromJson(response.data);
      } else {
        throw Failure("Failled to Videos");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }

  Future<ResultModul> submitQuiz({uid, topicid, corret, incorret, quiz}) async {
    try {
      final response =
          await Dio().post(AppString.baseurl + "api/quiz/answer", data: {
        'uid': uid,
        'topicid': topicid,
        'quiz': quiz,
        'corret': corret,
        'incorret': incorret
      });
      if (response.statusCode == 200) {
        return ResultModul.fromJson(response.data);
      } else {
        throw Failure("Failled to Answer Quiz");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }

  Future<ResultModul> submitEsay({uid, topicid, esay}) async {
    try {
      final response = await Dio().post(AppString.baseurl + "api/esay/answer",
          data: {'uid': uid, 'topicid': topicid, 'answer': esay});
      if (response.statusCode == 200) {
        return ResultModul.fromJson(response.data);
      } else {
        throw Failure("Failled to Answer Quiz");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }

  Future<AnswerModul> fetchAnswer({String? uid, String? topicid}) async {
    try {
      final response = await Dio().post(AppString.baseurl + "api/answer",
          data: {'uid': uid, 'topicid': topicid});
      if (response.statusCode == 200) {
        return AnswerModul.fromJson(response.data);
      } else {
        throw Failure("Failled to Videos");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }

  Future<AnswerEsayModul> fetchAnswerEsay(
      {String? uid, String? topicid}) async {
    try {
      final response = await Dio().post(AppString.baseurl + "api/answer/esay",
          data: {'uid': uid, 'topicid': topicid});
      if (response.statusCode == 200) {
        return AnswerEsayModul.fromJson(response.data);
      } else {
        throw Failure("Failled to Videos");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }

  Future<GalleryModul> fetchGallery({String? uid}) async {
    try {
      final response = await Dio()
          .post(AppString.baseurl + "api/gallery", data: {'uid': uid});
      if (response.statusCode == 200) {
        return GalleryModul.fromJson(response.data);
      } else {
        throw Failure("Failled to Videos");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }

  Future<GalleryModul> fetchEksperimen({String? uid, String? materiid}) async {
    try {
      final response = await Dio().post(AppString.baseurl + "api/eksperimen",
          data: {'uid': uid, 'materiid': materiid});
      if (response.statusCode == 200) {
        return GalleryModul.fromJson(response.data);
      } else {
        throw Failure("Failled to Eksperimen");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }

  Future<ResultModul> addGallery({uid, photo, desc}) async {
    try {
      FormData formData;
      String fileName = photo.split('/').last;
      formData = FormData.fromMap({
        'uid': uid,
        'desc': desc,
        'image': await MultipartFile.fromFile(photo, filename: fileName),
      });
      final response = await Dio()
          .post(AppString.baseurl + "api/gallery/add", data: formData);
      if (response.statusCode == 200) {
        return ResultModul.fromJson(response.data);
      } else {
        throw Failure("Failled to Videos");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }

  Future<ResultModul> addEksperimen(
      {uid, photo, desc, sekolahid, materiid}) async {
    try {
      FormData formData;
      String fileName = photo.split('/').last;
      formData = FormData.fromMap({
        'sekolahid': sekolahid,
        'materiid': materiid,
        'uid': uid,
        'desc': desc,
        'image': await MultipartFile.fromFile(photo, filename: fileName),
      });
      final response = await Dio()
          .post(AppString.baseurl + "api/eksperimen/add", data: formData);
      if (response.statusCode == 200) {
        return ResultModul.fromJson(response.data);
      } else {
        throw Failure("Failled to Videos");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }

  Future<SertifikatModul> fetchSertifikat({String? uid}) async {
    try {
      final response = await Dio()
          .post(AppString.baseurl + "api/sertifikat", data: {'uid': uid});
      if (response.statusCode == 200) {
        return SertifikatModul.fromJson(response.data);
      } else {
        throw Failure("Failled to Videos");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }

  Future<MateriModel> fetchMateri() async {
    try {
      final response = await Dio().get(AppString.baseurl + "api/materi");
      if (response.statusCode == 200) {
        return MateriModel.fromJson(response.data);
      } else {
        throw Failure("Failled to Materi");
      }
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw Failure('Connection time out');

        case DioErrorType.other:
          throw Failure(e.response!.statusCode.toString());

        default:
          throw Failure(e.response!.statusCode.toString());
      }
    }
  }
}

class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class UserModel {
  UserModel({
    required this.status,
    required this.result,
  });
  late final bool status;
  late final List<ResultUser> result;

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        List.from(json['result']).map((e) => ResultUser.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ResultUser {
  ResultUser({
    required this.uid,
    required this.email,
    required this.displayname,
    required this.userid,
    required this.jenjang,
    required this.sekolahid,
    required this.jurusan,
    required this.active,
    required this.level,
    required this.avatar,
    required this.batch,
  });
  late final String uid;
  late final String email;
  late final String displayname;
  late final String userid;
  late final String jenjang;
  late final String sekolahid;
  late final String jurusan;
  late final int active;
  late final int level;
  late final int batch;
  late final String avatar;

  ResultUser.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    displayname = json['displayname'];
    userid = json['userid'];
    jenjang = json['jenjang'];
    sekolahid = json['sekolahid'];
    jurusan = json['jurusan'];
    active = json['active'];
    level = json['level'];
    batch = json['batch'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uid'] = uid;
    _data['email'] = email;
    _data['displayname'] = displayname;
    _data['userid'] = userid;
    _data['jenjang'] = jenjang;
    _data['sekolahid'] = sekolahid;
    _data['jurusan'] = jurusan;
    _data['active'] = active;
    _data['level'] = level;
    _data['batch'] = batch;
    _data['avatar'] = avatar;
    return _data;
  }
}

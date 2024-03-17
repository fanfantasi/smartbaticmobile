class GalleryModul {
  GalleryModul({
    required this.status,
    required this.result,
  });
  late final bool status;
  late final List<ResultGallery> result;

  GalleryModul.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = List.from(json['result'])
        .map((e) => ResultGallery.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ResultGallery {
  ResultGallery({
    required this.uid,
    required this.date,
    required this.desc,
    required this.image,
  });
  late final String uid;
  late final String date;
  late final String desc;
  late final String image;

  ResultGallery.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    date = json['date'];
    desc = json['desc'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uid'] = uid;
    _data['date'] = date;
    _data['desc'] = desc;
    _data['image'] = image;
    return _data;
  }
}

class BannersModel {
  BannersModel({
    required this.status,
    required this.result,
  });
  late final bool status;
  late final List<ResultBanners> result;

  BannersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = List.from(json['result'])
        .map((e) => ResultBanners.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ResultBanners {
  ResultBanners({
    required this.url,
    required this.image,
  });
  late final String url;
  late final String image;

  ResultBanners.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['image'] = image;
    return _data;
  }
}

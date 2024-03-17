class VideosModel {
  VideosModel({
    required this.status,
    required this.result,
  });
  late final bool status;
  late final List<ResultVideos> result;

  VideosModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        List.from(json['result']).map((e) => ResultVideos.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['result'] = result.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ResultVideos {
  ResultVideos({
    required this.id,
    required this.title,
    required this.batch,
    required this.date,
    required this.read,
    required this.url,
    required this.thumbnail,
  });
  late final int id;
  late final String title;
  late final int batch;
  late final String date;
  late final int read;
  late final String url;
  late final Thumbnail thumbnail;

  ResultVideos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    batch = json['batch'];
    date = json['date'];
    read = json['read'];
    url = json['url'];
    thumbnail = Thumbnail.fromJson(json['thumbnail']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['batch'] = batch;
    _data['date'] = date;
    _data['read'] = read;
    _data['url'] = url;
    _data['thumbnail'] = thumbnail.toJson();
    return _data;
  }
}

class Thumbnail {
  Thumbnail({
    required this.standar,
    required this.medium,
    required this.high,
  });
  late final Standar standar;
  late final Medium medium;
  late final High high;

  Thumbnail.fromJson(Map<String, dynamic> json) {
    standar = Standar.fromJson(json['default']);
    medium = Medium.fromJson(json['medium']);
    high = High.fromJson(json['high']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['default'] = standar.toJson();
    _data['medium'] = medium.toJson();
    _data['high'] = high.toJson();
    return _data;
  }
}

class Standar {
  Standar({
    required this.url,
    required this.width,
    required this.height,
  });
  late final String url;
  late final int width;
  late final int height;

  Standar.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['width'] = width;
    _data['height'] = height;
    return _data;
  }
}

class Medium {
  Medium({
    required this.url,
    required this.width,
    required this.height,
  });
  late final String url;
  late final int width;
  late final int height;

  Medium.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['width'] = width;
    _data['height'] = height;
    return _data;
  }
}

class High {
  High({
    required this.url,
    required this.width,
    required this.height,
  });
  late final String url;
  late final int width;
  late final int height;

  High.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['width'] = width;
    _data['height'] = height;
    return _data;
  }
}

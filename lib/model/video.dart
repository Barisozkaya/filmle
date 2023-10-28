class Video {
  int? _id;
  List<Results>? _results;

  Video({int? id, List<Results>? results}) {
    if (id != null) {
      _id = id;
    }
    if (results != null) {
      _results = results;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  List<Results>? get results => _results;
  set results(List<Results>? results) => _results = results;

  Video.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    if (json['results'] != null) {
      _results = <Results>[];
      json['results'].forEach((v) {
        _results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    if (_results != null) {
      data['results'] = _results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? _key;
  Results({
    String? key,
  }) {
    if (key != null) {
      _key = key;
    }
  }

  String? get key => _key;
  set key(String? key) => _key = key;

  Results.fromJson(Map<String, dynamic> json) {
    _key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['key'] = _key;
    return data;
  }
}

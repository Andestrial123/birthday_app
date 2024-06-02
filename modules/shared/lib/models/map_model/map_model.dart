class MapModel {
  String? _coords;
  String? _title;

  String? get coords => _coords;

  String? get title => _title;

  setCoords(value) {
    _coords = value;
  }

  setTitle(value) {
    _title = value;
  }

  MapModel({String? coords, String? title}) {
    _coords = coords;
    _title = title;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coords'] = _coords;
    map['title'] = _title;
    return map;
  }

  MapModel.fromJson(dynamic json) {
    _coords = json['coords'];
    _title = json['title'];
  }
}

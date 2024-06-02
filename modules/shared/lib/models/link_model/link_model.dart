class LinkModel {
  String? _link;
  String? _title;

  String? get link => _link;

  String? get title => _title;

  setLink(value) {
    _link = value;
  }

  setTitle(value) {
    _title = value;
  }

  LinkModel({String? link, String? title}) {
    _link = link;
    _title = title;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['link'] = _link;
    map['title'] = _title;
    return map;
  }

  LinkModel.fromJson(dynamic json) {
    _link = json['link'];
    _title = json['title'];
  }
}

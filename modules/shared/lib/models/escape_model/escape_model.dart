class EscapeModel {
  int? _count;

  int? get count => _count;

  setCount(value) {
    _count = value;
  }

  EscapeModel(int? count) {
    _count = count;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['count'] = _count;
    return map;
  }

  EscapeModel.fromJson(dynamic json) {
    _count = json['count'];
  }
}

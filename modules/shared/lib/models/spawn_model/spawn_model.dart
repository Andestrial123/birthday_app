class SpawnModel {
  int? _count;

  int? get count => _count;

  setCount(value) {
    _count = value;
  }

  SpawnModel(int? count) {
    _count = count;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['count'] = _count;
    return map;
  }

  SpawnModel.fromJson(dynamic json) {
    _count = json['count'];
  }
}

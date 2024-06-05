enum ChallengeType { quiz, mapSearching, funnyLink, spawnButtons, escapeButton, whitePixel }

class BaseModel<T> {
  ChallengeType? _challengeType;
  T? _data;

  ChallengeType? get challengeType => _challengeType;

  T? get data => _data;

  BaseModel({ChallengeType? challengeType, T? data})
      : _challengeType = challengeType,
        _data = data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['challengeType'] = _challengeType.toString();
    map['data'] = _data;
    return map;
  }

  BaseModel.fromJson(dynamic json) {
    _challengeType = json['challengeType'];
    _data = json['data'];
  }
}

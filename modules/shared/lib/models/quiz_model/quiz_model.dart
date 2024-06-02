class QuizModel {
  String? _question;
  List<Answers>? _answers;

  String? get question => _question;

  List<Answers>? get answers => _answers;

  QuizModel({String? question, List<Answers>? answers}) {
    _question = question;
    _answers = answers;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question'] = _question;
    map['answers'] = _answers?.map((e) => e.toJson()).toList() ?? [];
    return map;
  }

  QuizModel.fromJson(dynamic json) {
    _question = json['question'];
    _answers = json['answers'] != null
        ? (json['answers'] as List).map((e) => Answers.fromJson(e)).toList()
        : null;
  }
}

class Answers {
  bool? _isCorrect;
  String? _title;

  bool? get isCorrect => _isCorrect;

  String? get title => _title;

  setIsCorrect(value){
    _isCorrect = value;
  }

  setTitle(value){
    _title = value;
  }

  Answers({bool? isCorrect, String? title}) {
    _isCorrect = isCorrect;
    _title = title;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isCorrect'] = _isCorrect;
    map['title'] = _title;
    return map;
  }

  Answers.fromJson(dynamic json) {
    _isCorrect = json['isCorrect'];
    _title = json['title'];
  }
}

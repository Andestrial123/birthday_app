import 'package:shared/shared.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(DatabaseReference userDb, DatabaseReference answersDb)
      : _db = userDb,
        _answersDb = answersDb,
        super(MainInitial()) {
    _answersDb.onValue.listen((event) {
      final newMap = event.snapshot.value as Map?;
      if (newMap != null) {
        emit(MainReceiveAnswer(Answers.fromJson(newMap)));
      }
    });
  }

  final DatabaseReference _db;
  final DatabaseReference _answersDb;

  Future<void> sendQuizEvent(BaseModel quizModel) async {
    _db.set(quizModel.toJson());
  }

  Future<void> sendLinkEvent(BaseModel quizModel) async {
    _db.set(quizModel.toJson());
  }

  Future<void> sendMapEvent(BaseModel quizModel) async {
    _db.set(quizModel.toJson());
  }
}

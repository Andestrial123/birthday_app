import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/models/base_model.dart';
import 'package:shared/models/quiz_model/quiz_model.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(DatabaseReference db)
      : _db = db,
        super(MainInitial());

  final DatabaseReference _db;

  Future<void> sendQuizEvent(BaseModel quizModel) async {
    _db.set(quizModel.toJson());
  }

  Future<void> sendLinkEvent(BaseModel quizModel) async {
    _db.set(quizModel.toJson());
  }

  Future<void> sendMapEvent(QuizModel quizModel) async {
    _db.set(quizModel);
  }
}

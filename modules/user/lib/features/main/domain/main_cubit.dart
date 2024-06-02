import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/models/quiz_model/quiz_model.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(DatabaseReference db)
      : _db = db,
        super(MainInitial()) {
    _db.onValue.listen((event) {
      final mapEvent = event.snapshot.value as Map;
      switch (mapEvent['challengeType']) {
        case "ChallengeType.quiz":
          emit(MainQuizState(QuizModel.fromJson(mapEvent['data'])));
      }
    });
  }

  final DatabaseReference _db;
}

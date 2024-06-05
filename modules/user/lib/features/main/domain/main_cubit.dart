import 'dart:math';

import 'package:shared/shared.dart';
import 'package:user/features/main/data/constats/constants.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(DatabaseReference db, DatabaseReference answerDb)
      : _db = db,
        _answersDb = answerDb,
        super(MainInitial()) {
    _db.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final mapEvent = event.snapshot.value as Map;
        switch (mapEvent['challengeType']) {
          case "ChallengeType.quiz":
            emit(MainQuizState(QuizModel.fromJson(mapEvent['data'])));
            break;
          case "ChallengeType.funnyLink":
            emit(MainLinkState(LinkModel.fromJson(mapEvent['data'])));
            break;
          case "ChallengeType.mapSearching":
            emit(MainMapState(MapModel.fromJson(mapEvent['data'])));
            break;
          case "ChallengeType.spawnButtons":
            print(mapEvent['data']);
            break;
          case "ChallengeType.escapeButton":
            print(mapEvent['data']);
            break;
          case "ChallengeType.whitePixel":
            emit(MainWhitePixelState());
            break;
        }
      }
    });
  }

  final DatabaseReference _db;
  final DatabaseReference _answersDb;

  Future<void> submitQuizAnswer(Answers answers) async {
    _db.remove();
    _answersDb.set(answers.toJson());
    if (answers.isCorrect == true) {
      emit(MainCorrectState());
      await Future.delayed(const Duration(seconds: 3));
      emit(MainInitial());
    } else {
      final random = Random();
      emit(MainIncorrectState(badList[random.nextInt(badList.length)]));
    }
  }

  Future<void> resetState({MainState? nextState}) async {
    if (nextState != null) {
      emit(nextState);
      await Future.delayed(const Duration(seconds: 3));
    }
    _db.remove();
    emit(MainInitial());
  }
}

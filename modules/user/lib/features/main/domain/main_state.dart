part of 'main_cubit.dart';

sealed class MainState {}

class MainInitial extends MainState {}

class MainQuizState extends MainState {
  final QuizModel data;

  MainQuizState(this.data);
}

class MainLinkState extends MainState {
  final LinkModel data;

  MainLinkState(this.data);
}

class MainMapState extends MainState {
  final MapModel data;

  MainMapState(this.data);
}

class MainCorrectState extends MainState {}

class MainWhitePixelState extends MainState {}

class MainIncorrectState extends MainState {
  final String badMove;

  MainIncorrectState(this.badMove);
}

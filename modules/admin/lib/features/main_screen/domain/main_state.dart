part of 'main_cubit.dart';

sealed class MainState {}

class MainInitial extends MainState {}

class MainSendQuizState extends MainState {}

class MainSendMapState extends MainState {}

class MainSendLinkState extends MainState {}

class MainReceiveAnswer extends MainState {
  final Answers answers;

  MainReceiveAnswer(this.answers);
}

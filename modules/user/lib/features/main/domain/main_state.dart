part of 'main_cubit.dart';

sealed class MainState {}

class MainInitial extends MainState {}

class MainQuizState extends MainState {
  final QuizModel data;

  MainQuizState(this.data);
}

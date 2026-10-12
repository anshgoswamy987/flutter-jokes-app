import 'package:joke_app/features/jokes/domain/entities/jokes.dart';

abstract class JokeState {
  const JokeState();
}

class JokeInitial extends JokeState {}

class JokeLoading extends JokeState {}

class JokeLoaded extends JokeState {
  final Joke joke;
  const JokeLoaded({required this.joke});
}

class JokeError extends JokeState {
  final String message;
  const JokeError({required this.message});
}

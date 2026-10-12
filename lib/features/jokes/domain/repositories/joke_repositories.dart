import 'package:joke_app/features/jokes/domain/entities/jokes.dart';

abstract class JokeRepositories {
  Future<Joke> getjoke();
}

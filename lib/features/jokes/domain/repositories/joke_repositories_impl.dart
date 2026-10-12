import 'package:joke_app/features/jokes/data/datasources/joke_remote_data_source.dart';
import 'package:joke_app/features/jokes/domain/repositories/joke_repositories.dart';
import 'package:joke_app/features/jokes/domain/entities/jokes.dart';

class JokeRepositoryImpl implements JokeRepositories {
  final JokeRemoteDataSource remoteDataSource;

  JokeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Joke> getjoke() async {
    try {
      final jokeModel = await remoteDataSource.getRandomJoke();
      return jokeModel;
    } catch (e) {
      throw Exception('Failed to fetch joke: $e');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:joke_app/features/jokes/data/models/jokes_model.dart';

abstract class JokeRemoteDataSource {
  Future<JokeModel> getRandomJoke();
}

class JokeRemoteDataSourceImpl implements JokeRemoteDataSource {
  final Dio dio;
  JokeRemoteDataSourceImpl({required this.dio});

  @override
  Future<JokeModel> getRandomJoke() async {
    final response = await dio.get(
      'https://v2.jokeapi.dev/joke/Programming?safe-mode',
    );
    if (response.statusCode == 200) {
      return JokeModel.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load a joke ');
    }
  }
}

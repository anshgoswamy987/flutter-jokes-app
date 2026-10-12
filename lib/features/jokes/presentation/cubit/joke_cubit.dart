import 'package:joke_app/features/jokes/domain/repositories/joke_repositories.dart';
import 'package:joke_app/features/jokes/presentation/cubit/joke_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JokeCubit extends Cubit<JokeState> {
  final JokeRepositories repository;
  JokeCubit({required this.repository}) : super(JokeInitial());

  Future<void> fetchJoke() async {
    emit(JokeLoading());
    try {
      final joke = await repository.getjoke();
      emit(JokeLoaded(joke: joke));
    } catch (e) {
      emit(JokeError(message: 'Failed to load a joke. Check your internet'));
    }
  }
}

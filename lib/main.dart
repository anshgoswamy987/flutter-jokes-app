import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joke_app/features/jokes/domain/repositories/joke_repositories_impl.dart';

import 'features/jokes/data/datasources/joke_remote_data_source.dart';
import 'features/jokes/presentation/cubit/joke_cubit.dart';
import 'features/jokes/presentation/screens/joke_screen.dart';

void main() {
  // 1. Dio client banaya
  final dio = Dio();

  // 2. Remote Data Source banaya
  final remoteDataSource = JokeRemoteDataSourceImpl(dio: dio);

  // 3. Repository mein Data Source inject kiya
  final repository = JokeRepositoryImpl(remoteDataSource: remoteDataSource);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final JokeRepositoryImpl repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dev Jokes',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: BlocProvider(
        create: (context) => JokeCubit(repository: repository),
        child: const JokeScreen(),
      ),
    );
  }
}

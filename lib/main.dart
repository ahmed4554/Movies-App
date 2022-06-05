
import 'package:final_task_movies/cubit/cubit.dart';
import 'package:final_task_movies/dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/bloc_observer.dart';
import 'cubit/states.dart';
import 'movies/movie_info.dart';
import 'movies/movie_list.dart';

void main() {
  DioHelper.dioGet();
  BlocOverrides.runZoned(() {
    runApp(const MovieApp());
    
  },blocObserver: MyBlocObserver());
}

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => MovieAppCubit()..getMovieList()..getGeners()),
      child: BlocConsumer<MovieAppCubit, MovieAppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: MovieScreen(),
            );
          }),
    );
  }
}

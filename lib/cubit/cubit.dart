import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:final_task_movies/dio/dio.dart';
import 'package:final_task_movies/end_points/end_points.dart';
import 'package:final_task_movies/models/search_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/geners_model.dart';
import '../models/movie_info_model.dart';
import '../models/movie_list_model.dart';
import '../movies/movie_info.dart';
import '../movies/movie_info_edit.dart';
import 'states.dart';

class MovieAppCubit extends Cubit<MovieAppStates> {
  MovieAppCubit() : super(MovieAppInitialState());
  static MovieAppCubit get(context) => BlocProvider.of(context);

  Movie? movieModel;
  void getMovieList() {
    emit(MovieAppLoadingState());
    DioHelper.getData(
        url: MOVIELIST,
        query: {'api_key': '2001486a0f63e9e4ef9c4da157ef37cd'}).then((value) {
      movieModel = Movie.fromJson(value.data);
      print(movieModel!.results![0].popularity.toString());
      emit(MovieAppGetSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(MovieAppGetFailedState());
    });
  }

  Geners? genr;
  void getGeners() {
    emit(MovieAppGetGenersLoadingState());
    DioHelper.getData(
        url: GENRES,
        query: {'api_key': '2001486a0f63e9e4ef9c4da157ef37cd'}).then((value) {
      genr = Geners.fromJson(value.data);
      emit(MovieAppGetGenersSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(MovieAppGetGenersFailedState());
    });
  }

  void getMovieGenr(int genre) {
    emit(MovieAppLoadingState());
    DioHelper.getData(url: MOVIELIST, query: {
      'api_key': '2001486a0f63e9e4ef9c4da157ef37cd',
      'with_genres': '$genre'
    }).then((value) {
      movieModel = Movie.fromJson(value.data);
      emit(MovieAppGetSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(MovieAppGetFailedState());
    });
  }

  MovieInnerInfo? innerInfo;
  void getMovieInfo(context, int id) {
    emit(MovieAppLoadingState());
    DioHelper.getData(
        url: 'movie/$id',
        query: {'api_key': '2001486a0f63e9e4ef9c4da157ef37cd'}).then((value) {
      innerInfo = MovieInnerInfo.fromJson(value.data);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => MovieInfoEdit(innerInfo)),
        ),
      );
      emit(MovieAppGetSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(MovieAppGetFailedState());
    });
  }

  SearchModel? searchModel;
  void getSearch(String text) {
    emit(MovieAppGetSearchLoadingState());
    DioHelper.getData(url: SEARCH, query: {
      'api_key': '2001486a0f63e9e4ef9c4da157ef37cd',
      'query': text
    }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(MovieAppGetSearchSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(MovieAppGetSearchFailedState());
    });
  }
}

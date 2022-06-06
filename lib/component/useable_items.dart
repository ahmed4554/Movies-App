import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_task_movies/cubit/cubit.dart';
import 'package:flutter/material.dart';

import '../models/geners_model.dart';

Widget buildMovieItme(context, model) {
  return InkWell(
    onTap: () {
      MovieAppCubit.get(context).getMovieInfo(context, int.parse(model.id.toString()));
    },
    child: Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.5),
        borderRadius: BorderRadius.circular(20),
      ),
      height: 250,
      width: double.infinity,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://image.tmdb.org/t/p/original${model.backdropPath}',
            height: 250,
            fit: BoxFit.fill,
            progressIndicatorBuilder: (context, url, progress) {
              if (progress.progress != null) {
                double present = progress.progress! * 100;
                return Center(
                  child: LinearProgressIndicator(
                    value: progress.progress!,
                  ),
                );
              } else {
                return const Center(child: Text("Image Loaded"));
              }
            },
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    model.voteAverage.toString(),
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7),
              width: double.infinity,
              color: Colors.black.withOpacity(.7),
              child: Text(
                model.title.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget buildCategoryItem(context, Genres model) {
  return InkWell(
    onTap: () {
      MovieAppCubit.get(context).getMovieGenr(int.parse(model.id.toString()));
    },
    child: Container(
      alignment: Alignment.center,
      height: 35,
      width: 110,
      decoration: BoxDecoration(
        color: const Color(0xff120C6E),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        model.name.toString(),
        style: const TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
Widget noResult(context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.menu,
          size: 120.0,
        ),
        const SizedBox(height: 20,),
        Text(
          'Search to view Movie',
          style: Theme.of(context).textTheme.headline3,
        )
      ],
    ),
  );
}

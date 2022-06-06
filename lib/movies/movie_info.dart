import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_task_movies/cubit/cubit.dart';
import 'package:final_task_movies/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../models/movie_info_model.dart';

class MovieInfoScreen extends StatelessWidget {
  MovieInnerInfo? model;
  MovieInfoScreen(this.model);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieAppCubit, MovieAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var c = MovieAppCubit.get(context);
          return Scaffold(
            body: c.innerInfo != null
                ? ListView(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff6BB2A0),
                              blurRadius: 9,
                              spreadRadius: 8,
                              offset: Offset(0, 0),
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0)),
                        ),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/original${model!.backdropPath}',
                              fit: BoxFit.fill,
                              progressIndicatorBuilder:
                                  (context, url, progress) {
                                if (progress.progress != null) {
                                  return LinearProgressIndicator(
                                      value: progress.progress);
                                } else {
                                  return const Text('Image Loaded');
                                }
                              },
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      model!.voteAverage.toString(),
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
                              alignment: Alignment.topRight,
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model!.originalTitle.toString(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Overview',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xff6BB2A0),
                                    blurRadius: 9,
                                    spreadRadius: 4,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                                color: const Color(0xffE0ECDE),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${model!.overview}',
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(child: Lottie.asset('assets/98432-loading.json')),
          );
        });
  }
}

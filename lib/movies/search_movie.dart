import 'package:final_task_movies/component/useable_items.dart';
import 'package:final_task_movies/cubit/cubit.dart';
import 'package:final_task_movies/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieAppCubit, MovieAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var c = MovieAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(title: Text('Search'),),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  onFieldSubmitted: (value) {
                    c.getSearch(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    label: Text('Search For Movie'),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (state is MovieAppGetSearchLoadingState)
                  Expanded(
                    child: Center(
                      child: Lottie.asset('assets/98432-loading.json'),
                    ),
                  ),
                c.searchModel != null
                    ? Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return buildMovieItme(
                                  context, c.searchModel!.results![index]);
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 15,
                              );
                            },
                            itemCount: c.searchModel!.results!.length),
                      )
                    : noResult(context),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_archive/logic/movies/movie_search_bloc.dart';
import 'package:movies_archive/logic/movies/movie_search_state.dart';
import 'package:movies_archive/utilities/constants/text_style.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies Archive"),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocConsumer<MovieSearchBloc, MovieSearchState>(
          builder: (context, state) {
        if (state is MovieSearchInitialState) {
          return const Center(
            child: Text("Please wait..."),
          );
        } else if (state is MovieSearchLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MovieSelectedSuccessState) {
          final movie = state.movie;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Image.network(
                      movie.poster,
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Title:',
                    style: textStyleHeading,
                  ),
                  Text(
                    movie.title,
                    style: textStyleDetails,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Year:',
                    style: textStyleHeading,
                  ),
                  Text(
                    movie.year,
                    style: textStyleDetails,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Rated:',
                    style: textStyleHeading,
                  ),
                  Text(
                    movie.rated,
                    style: textStyleDetails,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Released:',
                    style: textStyleHeading,
                  ),
                  Text(
                    movie.released,
                    style: textStyleDetails,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Runtime:',
                    style: textStyleHeading,
                  ),
                  Text(
                    movie.runtime,
                    style: textStyleDetails,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Genre:',
                    style: textStyleHeading,
                  ),
                  Text(
                    movie.genre,
                    style: textStyleDetails,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Director:',
                    style: textStyleHeading,
                  ),
                  Text(
                    movie.director,
                    style: textStyleDetails,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Writer:',
                    style: textStyleHeading,
                  ),
                  Text(
                    movie.writer,
                    style: textStyleDetails,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Actors:',
                    style: textStyleHeading,
                  ),
                  Text(
                    movie.actors,
                    style: textStyleDetails,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Plot:',
                    style: textStyleHeading,
                  ),
                  Text(
                    movie.plot,
                    style: textStyleDetails,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Language:',
                    style: textStyleHeading,
                  ),
                  Text(
                    movie.language,
                    style: textStyleDetails,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Country:',
                    style: textStyleDetails,
                  ),
                  Text(
                    movie.country,
                    style: textStyleDetails,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Awards:',
                    style: textStyleHeading,
                  ),
                  Text(
                    movie.awards,
                    style: textStyleDetails,
                  ),
                ],
              ),
            ),
          );
        } else if (state is MovieSearchFailureState) {
          return Center(child: Text(state.errorMessage.toString()));
        } else {
          return Container();
        }
      }, listener: (context, state) {
        if (state is MovieSearchFailureState) {
          AwesomeDialog(
            context: context,
            isDense: false,
            animType: AnimType.topSlide,
            dialogType: DialogType.error,
            body: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text("some thing went wrong"),
            ),
            btnOkOnPress: () {},
          ).show();
        }
      }),
    );
  }
}

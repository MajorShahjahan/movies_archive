import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_archive/logic/movies/movie_search_event.dart';
import 'package:movies_archive/logic/movies/movie_search_state.dart';
import '../../../logic/movies/movie_search_bloc.dart';

class MoviesSearchScreen extends StatefulWidget {
  const MoviesSearchScreen({Key? key}) : super(key: key);

  @override
  State<MoviesSearchScreen> createState() => _MoviesSearchScreenState();
}

class _MoviesSearchScreenState extends State<MoviesSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieSearchBloc, MovieSearchState>(
      listener: (context, state) {
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
      },
      builder: (context, state) {
        if (state is MovieSearchInitialState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Movies Archive"),
              backgroundColor: Colors.transparent,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    height: 60,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF292B37),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search,
                          color: Colors.white24,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextFormField(
                            onFieldSubmitted: (query) {
                              context.read<MovieSearchBloc>().add(
                                    MovieSearchStartedEvent(
                                        query: query.trim().toLowerCase()),
                                  );
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 7),
                              border: InputBorder.none,
                              hintText: "Search...",
                              hintStyle: TextStyle(color: Colors.white24),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is MovieSearchLoadingState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Movies Archive"),
              backgroundColor: Colors.transparent,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    height: 60,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF292B37),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search,
                          color: Colors.white24,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextFormField(
                            onFieldSubmitted: (query) {
                              context.read<MovieSearchBloc>().add(
                                    MovieSearchStartedEvent(
                                        query: query.trim().toLowerCase()),
                                  );
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 7),
                              border: InputBorder.none,
                              hintText: "Search...",
                              hintStyle: TextStyle(color: Colors.white24),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              ),
            ),
          );
        } else if (state is MovieSearchSuccessState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Movies Archive"),
              backgroundColor: Colors.transparent,
            ),
            body: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(top: 20, right: 10, left: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF292B37),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search,
                          color: Colors.white24,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextFormField(
                            onFieldSubmitted: (query) {
                              context.read<MovieSearchBloc>().add(
                                    MovieSearchStartedEvent(
                                        query: query.trim().toLowerCase()),
                                  );
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 7),
                              border: InputBorder.none,
                              hintText: "Search...",
                              hintStyle: TextStyle(color: Colors.white24),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: state.movies?.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          final movie = state.movies![index];
                          return InkWell(
                            onTap: () {
                              context.read<MovieSearchBloc>().add(
                                  MovieSelectedEvent(imdbID: movie.imdbID));
                              Navigator.pushNamed(context, "/movie_details");
                            },
                            child: Container(
                              width: 190,
                              height: 230,
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                  color: const Color(0xFF292B37),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF292B37)
                                          .withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 6,
                                    )
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    child: Image.network(
                                      movie.poster,
                                      height: 140,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        } else if (state is MovieSearchFailureState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Movies Archive"),
              backgroundColor: Colors.transparent,
            ),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF292B37),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search,
                          color: Colors.white24,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextFormField(
                            onFieldSubmitted: (query) {
                              context.read<MovieSearchBloc>().add(
                                    MovieSearchStartedEvent(
                                        query: query.trim().toLowerCase()),
                                  );
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 7),
                              border: InputBorder.none,
                              hintText: "Search...",
                              hintStyle: TextStyle(color: Colors.white24),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Center(
                    child: Text("Some Thing went wrong"),
                  )
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Movies Archive"),
              backgroundColor: Colors.transparent,
            ),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF292B37),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search,
                          color: Colors.white24,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextFormField(
                            onFieldSubmitted: (query) {
                              context.read<MovieSearchBloc>().add(
                                    MovieSearchStartedEvent(
                                        query: query.trim().toLowerCase()),
                                  );
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 7),
                              border: InputBorder.none,
                              hintText: "Search...",
                              hintStyle: TextStyle(color: Colors.white24),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

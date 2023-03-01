import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_archive/logic/movies/movie_search_bloc.dart';
import 'package:movies_archive/logic/network/network_bloc.dart';
import 'package:movies_archive/logic/network/network_state.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:movies_archive/presentation/screens/movie_detail_screen/detail_screen.dart';
import 'package:movies_archive/presentation/screens/movies_search_screen/search_screen.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (BuildContext context) => NetworkBloc()),
      BlocProvider(create: (BuildContext context) => MovieSearchBloc()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0F111D),
      ),
      routes: {
        "/": (context) => const HomeScreen(),
        "/movies_search": (context) => const MoviesSearchScreen(),
        "/movie_details": (context) => const MovieDetailsScreen(),
      },
    ),
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NetworkBloc, NetworkState>(
      listener: (context, networkState) {
        if (networkState is NetworkDisconnectedState) {
          AwesomeDialog(
            context: context,
            isDense: false,
            animType: AnimType.topSlide,
            dialogType: DialogType.error,
            body: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text("Internet lost"),
            ),
            btnOkOnPress: () {},
          ).show();
        }
      },
      builder: (context, networkState) {
        if (networkState is NetworkConnectedState) {
          return const MoviesSearchScreen();
        } else if (networkState is NetworkDisconnectedState) {
          return Scaffold(
            appBar: AppBar(title: const Text("Movies Archive")),
            body: const Center(
              child: Text("Internet Connection Lost!"),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_app/services/api.dart';
import 'package:movie_app/widgets/movie_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late Future _allMovies;

  @override
  void initState() {
    super.initState();

    _allMovies = _fetchMovies();
  }

  Future _fetchMovies() async {
    try {
      final apiCalls = await Future.wait(
        [
          MoviesApiService.loadData(1),
          MoviesApiService.loadData(2),
          MoviesApiService.loadData(3),
        ],
      );

      return apiCalls;
    } catch (e) {
      throw Exception("Failed to load movies: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _allMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.hasData) {
            final movieResults = snapshot.data;
            final trendingMovies = movieResults[0];
            final mostPopularMovies = movieResults[1];
            final recommendedMovies = movieResults[2];

            return SingleChildScrollView(
              child: Column(
                children: [
                  MovieList(
                    movieList: trendingMovies,
                    title: 'Trending',
                  ),
                  MovieList(
                    movieList: mostPopularMovies,
                    title: 'Most Popular',
                  ),
                  MovieList(
                    movieList: recommendedMovies,
                    title: 'Recommended',
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}



 


//
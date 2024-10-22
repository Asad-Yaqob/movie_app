import 'package:flutter/material.dart';
import 'package:movie_app/services/api.dart';
import 'package:movie_app/screens/movie_detail.dart';
import 'package:transparent_image/transparent_image.dart';

class SearchList extends StatelessWidget {
  const SearchList({super.key, this.searchResult});

  final Future? searchResult;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: searchResult,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text(
                    'Searching...',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Something Went Wronge :(',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            );
          }

          if (snapshot.hasData) {
            final data = snapshot.data;

            if (data != null && data['tv_shows'] is List) {
              final movie = data['tv_shows'];

              if (movie.isEmpty) {
                return const Center(
                  child: Text(
                    "No movies found.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                );
              }

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                child: ListView.builder(
                  itemCount: movie.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                      ),
                      child: ListTile(
                        title: Text(movie[index]['name']),
                        leading: Hero(
                          tag: movie[index]['id'],
                          child: FadeInImage(
                            placeholder: MemoryImage(kTransparentImage),
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                            image: NetworkImage(
                                movie[index]['image_thumbnail_path']),
                          ),
                        ),
                        trailing: const Icon(
                          Icons.play_arrow_outlined,
                        ),
                        onTap: () async {
                          final movieName = movie[index]['permalink'];
                          final movieDetail =
                              await MoviesApiService.getMovieDetail(movieName);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetail(
                                movieDetails: movieDetail,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            }
          }

          return Container();
        });
  }
}

import 'package:flutter/material.dart';
import 'package:movie_app/services/api.dart';
import 'package:movie_app/screens/movie_detail.dart';
import 'package:movie_app/widgets/custome_heading.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieList extends StatelessWidget {
  const MovieList({
    super.key,
    required this.title,
    required this.movieList,
  });

  final String title;
  final Map<String, dynamic> movieList;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final tvShows = movieList['tv_shows'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: CustomeHeading(fontSize: 20, title: title,),
        ),
        const SizedBox(
          height: 2,
        ),
        SizedBox(
          height: media.height / 4,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tvShows.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  final movieName = tvShows[index]['permalink'];
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
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.all(12),
                  child: Hero(
                    tag: tvShows[index]['id'],
                    child: FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      image: NetworkImage(
                        tvShows[index]['image_thumbnail_path'],
                      ),
                      fit: BoxFit.fill,
                      height: 200,
                      width: 130,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

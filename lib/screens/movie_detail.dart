import 'package:flutter/material.dart';
import 'package:movie_app/widgets/carousel.dart';
import 'package:movie_app/widgets/custome_heading.dart';
import 'package:movie_app/widgets/custome_text.dart';
import 'package:movie_app/widgets/movie_sub_detail.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({super.key, required this.movieDetails});

  final Map<String, dynamic> movieDetails;

  @override
  Widget build(BuildContext context) {
   void showAlertDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Icon(
              Icons.new_releases_outlined,
              size: 40,
            ),
            content: const CustomeText(
              title: 'Oopps. This feature is not available yet.',
              fontSize: 14,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }

    final tvShow = movieDetails['tvShow'];

    // Extracting the data
    final id = tvShow['id'];
    final name = tvShow['name'] ?? 'N/A';
    final country = tvShow['country'] ?? 'N/A';
    final network = tvShow['network'] ?? 'N/A';
    final rating = tvShow['rating'] ?? 'N/A';
    final description = tvShow['description'] ?? 'N/A';
    final pictures = List<String>.from(tvShow['pictures'] ?? []);
    final genres = List<String>.from(tvShow['genres'] ?? []);

    return Scaffold(
      appBar: AppBar(
        title: CustomeHeading(
          fontSize: 18,
          title: name,
        ),
      ),
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Carousel(
              id: id,
              pictures: pictures,
            ),
            const SizedBox(height: 12),
            MovieSubDetail(
              name: name,
              network: network,
              country: country,
              rating: rating,
              genres: genres,
              description: description,
              onTap: showAlertDialog,
            ),
          ],
        ),
      ),
    );
  }
}

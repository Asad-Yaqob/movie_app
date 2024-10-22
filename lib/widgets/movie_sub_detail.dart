import 'package:flutter/material.dart';
import 'package:movie_app/widgets/custome_heading.dart';
import 'package:movie_app/widgets/custome_text.dart';

class MovieSubDetail extends StatelessWidget {
  const MovieSubDetail({
    super.key,
    required this.name,
    required this.network,
    required this.country,
    required this.rating,
    required this.genres,
    required this.description,
    required this.onTap,
  });

  final String name;
  final String network;
  final String country;
  final String rating;
  final List genres;
  final String description;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomeHeading(fontSize: 24, title: name),
              const SizedBox(
                height: 12,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomeHeading(
                    title: 'Network',
                    fontSize: 18,
                  ),
                  CustomeHeading(
                    title: 'Country',
                    fontSize: 18,
                  ),
                  CustomeHeading(
                    title: 'Rating',
                    fontSize: 18,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomeText(
                    title: network,
                    fontSize: 14,
                  ),
                  CustomeText(
                    title: country,
                    fontSize: 14,
                  ),
                  CustomeText(
                    title: double.tryParse(rating)?.toStringAsFixed(1) ?? '0.0',
                    fontSize: 14,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const CustomeHeading(
                title: 'Genres',
                fontSize: 18,
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: genres
                      .map(
                        (genre) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomeText(title: genre, fontSize: 16),
                        ),
                      )
                      .toList()),
              const SizedBox(
                height: 14,
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Play',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.download,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Download',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomeHeading(
                        title: 'Description',
                        fontSize: 18,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        description,
                        textAlign: TextAlign.justify,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:transparent_image/transparent_image.dart';

class Carousel extends StatelessWidget {
  const Carousel({super.key, required this.id, required this.pictures,});

  final int id;
  final List pictures;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return  CarouselSlider.builder(
              itemCount: pictures.length,
              itemBuilder: (context, index, realIndex) {
                return pictures.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Hero(
                            tag: id,
                            child: FadeInImage(
                              height: 150,
                              width: media.width,
                              fit: BoxFit.cover,
                              placeholder: MemoryImage(kTransparentImage),
                              image: NetworkImage(pictures[index]),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.grey, // Placeholder if no image
                        child: const Center(
                          child: Text(
                            'No Image Available :( ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
              },
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1,
                autoPlayInterval: const Duration(seconds: 4),
              ),
            );
  }
}
import 'package:flutter/material.dart';
import 'package:movie_app/services/api.dart';
import 'package:movie_app/screens/movie_detail.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen>
    with SingleTickerProviderStateMixin {
  final _scrollControler = ScrollController();
  late AnimationController _animationController;
  int _page = 1;
  bool _isLoading = false;
  List _movies = [];

  @override
  void initState() {
    _scrollControler.addListener(_scrollListener);
    _fetchMovies();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
          controller: _scrollControler,
          itemCount: _isLoading ? _movies.length + 1 : _movies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (ctx, index) {
            if (index < _movies.length) {
              return AnimatedBuilder(
                animation: _animationController,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.all(16),
                  child: InkWell(
                    onTap: () async {
                      final movieName = _movies[index]['permalink'];
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
                    child: Hero(
                      tag: _movies[index]['id'],
                      child: FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: NetworkImage(
                          _movies[index]['image_thumbnail_path'],
                        ),
                        fit: BoxFit.fill,
                        height: 200,
                        width: 130,
                      ),
                    ),
                  ),
                ),
                builder: (context, child) => SlideTransition(
                  position:
                      Tween(begin: const Offset(0.0, 0.5), end: Offset.zero)
                          .animate(
                    CurvedAnimation(
                        parent: _animationController, curve: Curves.easeInOut),
                  ),
                  child: child,
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Future<void> _fetchMovies() async {
    try {
      final response = await MoviesApiService.loadData(_page);
      final List data = response['tv_shows'];

      setState(() {
        _movies = _movies + data;
      });
    } catch (e) {
      print(e);
    }
  }

  void _scrollListener() async {
    if (_isLoading) return;

    if (_scrollControler.position.pixels ==
        _scrollControler.position.maxScrollExtent) {
      setState(() {
        _isLoading = true;
      });

      _page += 1;
      await _fetchMovies();

      setState(() {
        _isLoading = false;
      });
    }
  }
}

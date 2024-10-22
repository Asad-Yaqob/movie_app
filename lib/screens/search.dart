import 'package:flutter/material.dart';
import 'package:movie_app/services/api.dart';
import 'package:movie_app/widgets/search_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Future? _searchResult;
  late Future _initialMovies ;
    
  @override
  void initState() {
    super.initState();

    setState(() {
       _initialMovies = MoviesApiService.loadData(5);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 44,
          child: TextField(
            style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search Movies, TV-Shows, Series...',
              filled: true,
              fillColor: const Color.fromARGB(255, 88, 87, 87),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 88, 87, 87), width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 88, 87, 87), width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _searchResult =
                          MoviesApiService.searchMovie(_searchController.text);
                    });
                  },
                  icon: const Icon(
                    Icons.search,
                  )),
            ),
          ),
        ),
      ),
      body: _searchResult == null
          ? SearchList(searchResult: _initialMovies)
          : SearchList(searchResult: _searchResult),
    );
  }
}

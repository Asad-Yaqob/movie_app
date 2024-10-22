import 'package:flutter/material.dart';
import 'package:movie_app/screens/home.dart';
import 'package:movie_app/screens/movie.dart';
import 'package:movie_app/screens/search.dart';
import 'package:movie_app/widgets/custome_heading.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;
  String _currentPagetitle = 'MovieShowie';

  void _switchIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const HomeScreen();

    if (_currentIndex == 1) {
      activePage = const MovieScreen();
      _currentPagetitle = 'Movies';
    }
    return Scaffold(
      appBar: AppBar(
        title: CustomeHeading(
          fontSize: 24,
          title: _currentPagetitle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(_searchRoute());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _switchIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.movie_creation_outlined), label: 'Movies'),
          ]),
    );
  }
}

Route _searchRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SearchScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: const Offset(1, 0.0), end: Offset.zero);
        var curveTween = CurveTween(curve: Curves.easeInOut);

        return SlideTransition(
          position: animation.drive(curveTween).drive(tween),
          child: child,
        );
      });
}

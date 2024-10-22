import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:movie_app/screens/tab.dart";

// import "package:movie_app/screens/movie.dart";
// import "package:movie_app/screens/search.dart";
// import "package:movie_app/screens/tab.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 147, 229, 250),
            brightness: Brightness.dark,
            surface: const Color.fromARGB(255, 42, 51, 59)),
        scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60),
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: const TabsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

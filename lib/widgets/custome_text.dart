import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomeText extends StatelessWidget {
  const CustomeText({
    super.key,
    required this.title,
    required this.fontSize,
    this.color = Colors.white,
  });

  final String title;
  final double fontSize;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          color: color,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomeHeading extends StatelessWidget {
  const CustomeHeading({
    super.key,
    required this.fontSize,
    required this.title,
    this.fontWeight,
    this.color = const Color(0xFFB0BEC5),
  });

  final String title;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
      maxLines: 1,
    );
  }
}

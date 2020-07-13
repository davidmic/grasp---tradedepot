import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: 'G',
          style: GoogleFonts.ubuntu(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 40,
          ),
          children: [
            TextSpan(
              text: 'RA',
              style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.bold,
                color: Color(0xff62D9A2),
                fontSize: 30,
              ),
            ),
            TextSpan(
              text: 'SP',
              style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.bold,
                color: Color(0xff62D9A2),
                fontSize: 30,
              ),
            ),
          ]
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClickableSingleTextRow extends StatelessWidget {
  final String firstChildText;
  final String secondChildText;
  final Function onTap;

  ClickableSingleTextRow({
    this.firstChildText,
    this.secondChildText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstChildText ?? '',
          style: GoogleFonts.montserrat(
            color: Colors.black,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            secondChildText ?? '',
            style: GoogleFonts.montserrat(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

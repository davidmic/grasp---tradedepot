import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructionText extends StatelessWidget {
  final String emphasisText;
  final String message;
  final bool useIcon;

  InstructionText({
    this.message,
    this.emphasisText,
    this.useIcon = false,
});

  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          emphasisText ?? "",
            style: GoogleFonts.playfairDisplay(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
        ),
        SizedBox(width: 5,),
        Flexible(
          child: Text(
            message ?? "",
              style: GoogleFonts.raleway(
                color: Colors.black,
                fontSize: 16,
              ),
          ),
        ),
       useIcon ? Icon(
          Icons.check_circle,
          size: 30,
          color: Color(0xff62D9A2),
        ) : Container(),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class Customtextwidget extends StatelessWidget {
  Customtextwidget({
    super.key,
    required this.text,
    required this.icon
  });
  String text;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(height: 10,),
        Icon(icon,size: 30,
          color: Colors.grey[800],
        ),
        SizedBox(width: 10,),
        LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = MediaQuery.of(context).size.width;
            double fontSize = screenWidth > 600 ? 18 : 14; // Responsive font size

            return Text(
              "$text",
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.w600,
                fontSize: fontSize,
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            );
          },
        )


      ],
    );
  }
}

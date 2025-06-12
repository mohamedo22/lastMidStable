import 'package:flutter/material.dart';

class Customcontacttextwidget extends StatelessWidget {
  Customcontacttextwidget({
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
        Icon(icon,size: 25,
          color: Colors.grey[800],
        ),
        SizedBox(width: 10,),
        Text("$text",
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey[800],
            fontWeight: FontWeight.w600
          ),
        )
      ],
    );
  }
}

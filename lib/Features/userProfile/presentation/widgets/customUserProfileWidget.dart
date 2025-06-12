import 'package:flutter/material.dart';

class Customuserprofilewidget extends StatelessWidget {
  Customuserprofilewidget({
    super.key,
    required this.icon,
    required this.value,
    required this.title
  });
  String title;
  String value;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            icon, size: 30,
            color: Colors.indigo,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$title : ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                      color: Colors.black
                  ),
                ),
                SizedBox(height: 5,),
                Text("$value ",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.black
                  ),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Customsettingscard extends StatelessWidget {
  IconData icon;
  String txt;
  Customsettingscard({super.key,required this.icon,required this.txt});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20,left: 15),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black54
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: Text(
                "${txt}",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                  color: Colors.black54
              ),
            )
          ],
        )
    );
  }
}

/*import 'package:flutter/material.dart';

class Customsettingscard extends StatelessWidget {
  IconData icon;
  String txt;
  Customsettingscard({super.key,required this.icon,required this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: Icon(
                  icon,
                size: 20,
                  color: Colors.black54
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: Text(
                "${txt}",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: Icon(
                  Icons.arrow_forward_ios_rounded,
                size: 15,
                  color: Colors.black54
              ),
            )
          ],
        )
    );
  }
}
*/
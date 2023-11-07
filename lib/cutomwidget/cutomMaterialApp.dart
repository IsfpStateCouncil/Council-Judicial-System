import 'package:flutter/material.dart';

import '../functions/mediaquery.dart';

class CutomMaterialApp extends StatelessWidget {
  const CutomMaterialApp({
    super.key,
    required this.name,
    required this.count,
    required this.color,
    required this.iconData,
  });
  final String name;
  final int count;
  final Color color;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        print(GetSizePage(context, 1, 100,""));
        print(GetSizePage(context, 1, 100,""));
      },
      color: color,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                "$name",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 50),
                      child: Icon(iconData, size: 40),
                      width: 20),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "$count",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      elevation: 20,
    );
  }
}

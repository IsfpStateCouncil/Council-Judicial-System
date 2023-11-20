import 'package:flutter/material.dart';

import '../functions/mediaquery.dart';

class CutomMaterialApp extends StatelessWidget {
  const CutomMaterialApp({
    super.key,
    required this.name,
    required this.count,
    required this.color,
    required this.iconData, required this.textColor,required this.fontFamily,
  });
  final String name;
  final int count;
  final Color color;
  final IconData iconData;
  final Color textColor;
  final String fontFamily;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
      },
      color: color,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                "$name",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: textColor,fontFamily: fontFamily,),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 50),
                      child: Icon(iconData, size: 40,color: textColor,),
                      width: 20),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "$count",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,color: textColor,fontFamily: fontFamily,),
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

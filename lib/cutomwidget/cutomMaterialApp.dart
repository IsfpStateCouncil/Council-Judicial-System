import 'package:flutter/material.dart';

class CutomMaterialApp extends StatelessWidget {
  const CutomMaterialApp({
    super.key,
    required this.name,
    required this.count,
    required this.color,
    required this.iconData,
    required this.textColor,
    required this.fontFamily,
    this.onPressed,
  });
  final String name;
  final int count;
  final Color color;
  final IconData iconData;
  final Color textColor;
  final String fontFamily;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      elevation: 30,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
                fontFamily: fontFamily,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                    //margin: const EdgeInsets.only(right: 40),
                    width: 20,
                    child: Icon(
                      iconData,
                      size: 40,
                      color: textColor,
                    )),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "$count",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontFamily: fontFamily,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

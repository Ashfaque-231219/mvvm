import 'package:flutter/material.dart';

import 'custom_label.dart';

class CustomRaisedButton extends StatelessWidget {
  const CustomRaisedButton({
    required this.text,
    required this.color,
    this.size = 14,
    this.textcolor = Colors.white,
    this.width = 160,
    this.height = 60,
    this.fontsFamily = '',
    required this.onpressed,
    this.sidecolor = Colors.blue,
    Key? key,
  }) : super(key: key);
  final String text;
  final double size;
  final Color color;
  final Color textcolor;
  final double width;
  final double height;
  final String fontsFamily;
  final VoidCallback onpressed;

  final Color sidecolor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            minimumSize: Size(width, height),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius:  BorderRadius.circular(8),
                side: BorderSide(
              color: sidecolor,
              
              width: 1,
            ))),
        onPressed: onpressed,
        child: CustomLabel(
          fontFamily: fontsFamily,
          text: text,
          size: size,
          alignment: TextAlign.center,
          color: textcolor,
          fontWeight: FontWeight.bold,
        ));
  }
}

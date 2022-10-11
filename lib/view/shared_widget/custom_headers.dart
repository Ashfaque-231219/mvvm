import 'package:flutter/material.dart';
import 'package:redwood_app/helper/constants/asset_const.dart';

class CustomHeader extends StatefulWidget {
  const CustomHeader({
    this.textFields = '',
    this.rightImage = '',
    this.visibleLeft = false,
    this.visibleRight = false,
    required this.leftButtonPressed,
    required this.rightButtonPressed,
    Key? key,
  }) : super(key: key);

  final String textFields;
  final bool visibleLeft;
  final bool visibleRight;

  final VoidCallback leftButtonPressed;
  final VoidCallback rightButtonPressed;
  final String rightImage;

  @override
  _CustomHeaderState createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: Text(
        widget.textFields,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: FontConst.MontserratFont,
          fontSize: 18,
        ),
      ),
      leading: IconButton(
        onPressed: widget.leftButtonPressed,
        icon: Visibility(
            visible: widget.visibleLeft,
            child: ImageIcon(
              AssetImage(ImageConst.backArrow),
              color: Colors.black,
              size: 30,
            )),
      ),
      actions: [
        Visibility(
          visible: widget.visibleRight,
          child: IconButton(
              icon: ImageIcon(
                AssetImage(widget.rightImage),
                color: Colors.black,
              ),
              onPressed: widget.rightButtonPressed),
        )
      ],
    );
  }
}

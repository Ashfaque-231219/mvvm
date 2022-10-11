import 'package:flutter/material.dart';
import 'package:redwood_app/helper/constants/color_const.dart';
import 'package:redwood_app/view/shared_widget/custom_raised_button.dart';


class CustomDialog extends StatelessWidget {
  const CustomDialog({Key? key, this.text = ''}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(text),
          ),
          CustomRaisedButton(
              text: 'ok',
              textcolor: ColorConst.white,
              width: 100,
              color: ColorConst.red,
              sidecolor:ColorConst.red ,
              onpressed: () {
                Navigator.pop(context, true);
              }),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

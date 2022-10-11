import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redwood_app/helper/constants/asset_const.dart';
import 'package:redwood_app/helper/constants/constants.dart';
import 'package:redwood_app/helper/utils/shared_pref.dart';
import 'package:redwood_app/route_generator.dart';
import 'package:redwood_app/view/shared_widget/custom_label.dart';
import 'package:redwood_app/view/shared_widget/custom_raised_button.dart';

import '../helper/constants/color_const.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({Key? key}) : super(key: key);

  @override
  State<WalkThroughScreen> createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(ImageConst.walkthruoghImage), fit: BoxFit.cover),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    top: height * 0.09,
                    child: CustomLabel(
                      text: ' Dedicated,\n dependable\n & focused',
                      size: 30,
                      fontFamily: FontConst.MontserratFont,
                      fontWeight: FontWeight.bold,
                    )),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.38),
                  child: CustomLabel(
                    text: 'Turn any stunning design concept into\n    reality, within the shortest possible\n                 time for our clients.',
                    size: 15,
                    fontFamily: FontConst.MontserratFont,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.03),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomRaisedButton(
                        onpressed: () async {
                          await SharedPref.setBool(key: Constants.walkThroughVisited, data: true);

                          Navigator.pushNamed(context, RoutesConst.login);
                        },
                        color: ColorConst.red,
                        text: 'Get Started',
                        size: 14,
                        textcolor: ColorConst.white,
                        height: height * 0.07,
                        width: width * 0.7,
                        fontsFamily: FontConst.MontserratFont,
                        sidecolor: ColorConst.red,
                      )),
                )
              ],
            )));
  }
}

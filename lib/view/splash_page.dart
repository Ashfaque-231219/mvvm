import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redwood_app/helper/constants/constants.dart';
import 'package:redwood_app/view/auth/login_screen.dart';
import 'package:redwood_app/view/dash_board/Landing_page.dart';
import 'package:redwood_app/view/shared_widget/custom_label.dart';
import 'package:redwood_app/view/walkthruogh_screen.dart';

import '../helper/utils/shared_pref.dart';
import '../route_generator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  _navigateToOnBoardScreen() async {
    await Future.delayed(const Duration(milliseconds: 5000), () {});
    navigate();
  }

  Future<void> navigate() async {
    var walkthroughVisited = await SharedPref.getBool(key: Constants.walkThroughVisited);
    print('The walkthrough screen $walkthroughVisited');
    var rememberMe = await SharedPref.getBool(key: Constants.rememberMe);

    if (walkthroughVisited) {
      if (rememberMe) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandingPage()));
      } else {
        // Navigator.pushReplacementNamed(context, RoutesConst.login);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    } else {
      // Navigator.pushReplacementNamed(context, RoutesConst.WalkThrough);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WalkThroughScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    _navigateToOnBoardScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      constraints: BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('asset/images/splash.jpg'), fit: BoxFit.cover),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: CustomLabel(
              text: '',
              // text: '\u00a9Copyright 2021.All rights reserved',
              color: Colors.white38,
            )),
      ),
    ));
  }
}

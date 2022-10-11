//! All routes are generated here
import 'package:flutter/material.dart';
import 'package:redwood_app/view/auth/edit_profile.dart';
import 'package:redwood_app/view/auth/forgot_otp_verification.dart';
import 'package:redwood_app/view/auth/forgot_pass_page.dart';
import 'package:redwood_app/view/auth/forgot_pass_save.dart';
import 'package:redwood_app/view/auth/login_screen.dart';
import 'package:redwood_app/view/dash_board/Landing_page.dart';
import 'package:redwood_app/view/splash_page.dart';
import 'package:redwood_app/view/walkthruogh_screen.dart';

import 'helper/utils/utils.dart';

class RoutesConst {
  // Routes Name
  static const splash = '/splash';
  static const WalkThrough = '/WalkThrough';
  static const login = '/ login';
  static const dashboard = '/dashboard';
  static const forgotpassword = '/forgotpassword';
  static const otpVerification = '/otpVerification ';
  static const forgotPassSave = '/forgotPassSave ';
  static const editProfile = '/editProfile  ';



  //Router...
  static Route<dynamic> generateRoute(RouteSettings settings) {
    printError('${settings.name}');
    printError('${settings.arguments}');
    Map<dynamic, dynamic>? params =
        settings.arguments == null ? null : settings.arguments as Map;
    switch (settings.name) {
      //! Splash Route
      case splash:
        return _GeneratePageRoute(
          widget: const SplashPage(),
          routeName: settings.name,
        );
      //! Walkthrough
      case WalkThrough:
        return _GeneratePageRoute(
          widget: const WalkThroughScreen(),
          routeName: settings.name,
        );

      //! Login Route
      case login:
        return _GeneratePageRoute(
          widget: const LoginScreen(),
          routeName: settings.name,
        );
      //! Forgot Password Route
      case forgotpassword:
        return _GeneratePageRoute(
          widget: const ForgotPassPage(),
          routeName: settings.name,
        );
      //   OTP Verification Routes
      case otpVerification:
        return _GeneratePageRoute(
          widget: const ForgotOtpVerification(),
          routeName: settings.name,
        );
      //  ForgotPassSave Route
      case forgotPassSave:
        return _GeneratePageRoute(
          widget: const ForgotPassSave(),
          routeName: settings.name,
        );

      // Dashboard
      case dashboard:
        return _GeneratePageRoute(
          widget: LandingPage(),
          routeName: settings.name,
        );
        // Edit Profile
      case editProfile:
        return _GeneratePageRoute(
          widget: EditProfile(),
          routeName: settings.name,
        );

      //! Default route (Invalid Url)
      default:
        return _GeneratePageRoute(
          widget: Scaffold(
            body: Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              width: 100,
              child: const Center(
                child: Text(
                  "Invalid url",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    fontFamily: "raleway",
                  ),
                ),
              ),
            ),
          ),
          routeName: '/error',
        );
    }
  }
}

//! Widget for generating routes with screen and route name (For Animation)
class _GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String? routeName;
  final bool isAction;

  _GeneratePageRoute({
    required this.widget,
    required this.routeName,
    this.isAction = false,
  }) : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            Animation<Offset> offset = isAction
                ? Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).animate(animation)
                : Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation);
            return SlideTransition(
              textDirection: TextDirection.ltr,
              position: offset,
              child: child,
            );
          },
        );
}

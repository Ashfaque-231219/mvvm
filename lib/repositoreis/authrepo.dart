import 'package:flutter/material.dart';

abstract class AuthRepo {
  Future loginService(Map<String, dynamic> req, BuildContext context);

  Future ForgotService(
    Map<String, dynamic> req,
  );

  Future verifyOtpService(
    Map<String, dynamic> req,
  );

  Future resetPasswordService(
    Map<String, dynamic> req,
  );

  Future logoutService();

  Future changePassServices(Map<String, dynamic> req, BuildContext context);

  Future editProfileServices(Map<String, dynamic> req, BuildContext context);

  Future getProfileServices(BuildContext context);
  Future reportType(BuildContext context);



}

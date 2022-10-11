import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:redwood_app/helper/utils/shared_pref.dart';
import 'package:redwood_app/models/change_pass_model/change_pass_model.dart';
import 'package:redwood_app/models/edit_profile_model.dart';
import 'package:redwood_app/models/forgot_pass_modal.dart';
import 'package:redwood_app/models/log_out_model/log_out_modal.dart';
import 'package:redwood_app/models/otp_verify_model.dart';
import 'package:redwood_app/models/user_details.dart';
import 'package:redwood_app/route_generator.dart';
import 'package:redwood_app/view/shared_widget/toast.dart';

import '../helper/constants/api_const.dart';
import '../models/login/get_report_type.dart';
import '../models/login/login_modal.dart';
import '../repositoreis/authrepo.dart';

class AuthService implements AuthRepo {
  final Dio dio;

  AuthService({required this.dio});

  @override
  Future loginService(Map<String, dynamic> req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConst.login, data: req);
      LoginModal loginModel = LoginModal.fromJson(response.data);
      ToastMessage.success(loginModel.message.toString());
      return loginModel;
    } catch (e) {
      var error = await SharedPref.getString(key: 'error-msg');

      ToastMessage.error(error);
      var statusCode = await SharedPref.getInt(key: 'error-code');
      print("The Strored status code is =====>>>>>>>>>> $statusCode");

      print(e.toString());
    }
  }

  @override
  Future ForgotService(Map<String, dynamic> req) async {
    try {
      Response response = await dio.post(ApiConst.forgotPass, data: req);

      ForgotPassModal forgotPassModal = ForgotPassModal.fromJson(response.data);
      ToastMessage.success(forgotPassModal.message.toString());
      return forgotPassModal;
    } catch (e) {
      var error = await SharedPref.getString(key: 'error-msg');

      ToastMessage.error(error);
      print(e.toString());
    }
  }

  @override
  Future verifyOtpService(Map<String, dynamic> req) async {
    try {
      Response response = await dio.post(ApiConst.verifyOtp, data: req);
      OTPVerifyMODEL otpVerifyMODEL = OTPVerifyMODEL.fromJson(response.data);

      ToastMessage.success(otpVerifyMODEL.message.toString());
      return otpVerifyMODEL;
    } catch (e) {
      var error = await SharedPref.getString(key: 'error-msg');
      ToastMessage.error(error);
      print(e.toString());
    }
  }

  @override
  Future resetPasswordService(Map<String, dynamic> req) async {
    try {
      Response response = await dio.post(ApiConst.resetPassword, data: req);
      OTPVerifyMODEL otpVerifyMODEL = OTPVerifyMODEL.fromJson(response.data);

      ToastMessage.success(otpVerifyMODEL.message.toString());
      return otpVerifyMODEL;
    } catch (e) {
      var error = await SharedPref.getString(key: 'error-msg');
      ToastMessage.error(error);
      print(e.toString());
    }
  }

  @override
  Future logoutService() async {
    try {
      Response response = await dio.post(
        ApiConst.logout,
      );
      LogoutModal logoutModal = LogoutModal.fromJson(response.data);
      ToastMessage.success(logoutModal.message.toString());
      return logoutModal;
    } catch (e) {
      var error = await SharedPref.getString(key: 'error-msg');
      ToastMessage.error(error);

      print(e.toString());
    }
  }

  @override
  Future changePassServices(Map<String, dynamic> req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConst.changePassword, data: req);
      // Navigator.pop(context);
      ToastMessage.showToast(context, response.data['message'], response.data['status']);
      ChangePassModel changePassModel = ChangePassModel.fromJson(response.data);
      return changePassModel;
    } catch (e) {
      var error = await SharedPref.getString(key: 'error-msg');
      ToastMessage.showToast(context, error, false);

      print("The message is $error");

      print(e.toString());
      var statusCode = await SharedPref.getInt(key: 'error-code');
      print("The Strored status code is =====>>>>>>>>>> $statusCode");
      if (statusCode == 401) {
        Navigator.pushNamedAndRemoveUntil(context, RoutesConst.login, (route) => false);
      }
    }
  }

  @override
  Future editProfileServices(Map<String, dynamic> req, BuildContext context) async {
    var imageMultipart;
    try {
      var image = req["image"]?.path.toString();
      print("The image is $image");
      if (image != null && image.toString().isNotEmpty) {
        var fileName = (image.toString().split('/').last);
        imageMultipart = await MultipartFile.fromFile(
          image,
          filename: fileName,
          contentType: MediaType(
            'image',
            fileName.toString().substring(
                  fileName.toString().lastIndexOf('.') + 1,
                ),
          ),
        );
        FormData formData = FormData.fromMap({
          'name': req['name'],
          'image': imageMultipart,
        });
        Response response = await dio.post(ApiConst.updateProfile, data: formData);
        EditProfileModel editProfileModel = EditProfileModel.fromJson(response.data);
        if (editProfileModel.success == true) {
          ToastMessage.success(editProfileModel.message.toString());
        }
        return editProfileModel;
      } else {
        Response response = await dio.post(ApiConst.updateProfile, data: req);

        EditProfileModel editProfileModel = EditProfileModel.fromJson(response.data);
        if (editProfileModel.success = true) {
          ToastMessage.success(editProfileModel.message.toString());
        }

        return editProfileModel;
      }
    } catch (e) {
      var statusCode = await SharedPref.getInt(key: 'error-code');

      if (statusCode == 410) {
        print("The Strored status code is =====>>>>>>>>>> $statusCode");
        Navigator.pushNamedAndRemoveUntil(context, RoutesConst.login, (route) => false);
        print(e.toString());
      }
    }
  }

  @override
  Future getProfileServices(BuildContext context) async {
    try {
      Response response = await dio.post(ApiConst.getProfile);
      UserDetail userDetail = UserDetail.fromJson(response.data);
      return userDetail;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future reportType(BuildContext context) async {
    try {
      Response response = await dio.get(ApiConst.getReportType);
      ReportTypeModel reportType = ReportTypeModel.fromJson(response.data);
      return reportType;
    } catch (e) {
      debugPrint(e.toString());

      var msg = await SharedPref.getString(key: "error-msg");
    }
  }
}

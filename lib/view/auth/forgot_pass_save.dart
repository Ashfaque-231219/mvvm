import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redwood_app/view-models/loginbloc/login_bloc.dart';
import 'package:redwood_app/view-models/loginbloc/login_state.dart';
import 'package:redwood_app/view/shared_widget/loading_widget.dart';

import '../../helper/constants/asset_const.dart';
import '../../helper/constants/color_const.dart';
import '../../helper/utils/shared_pref.dart';
import '../shared_widget/custom_label.dart';
import '../shared_widget/custom_password_filed.dart';
import '../shared_widget/custom_raised_button.dart';

class ForgotPassSave extends StatefulWidget {
  const ForgotPassSave({Key? key}) : super(key: key);

  @override
  State<ForgotPassSave> createState() => _ForgotPassSaveState();
}

class _ForgotPassSaveState extends State<ForgotPassSave> {
  TextEditingController _newPassController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String newPasswords;
  late String confirmPasswords;

  triggerEvent(ResetPasswordEvent event) {
    context.read<LoginBloc>().add(event);
  }
  navigate(){
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 2);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async{

          return  navigate();


          },
          child: Scaffold(
            body: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: LoadingWidget(
                status: state.stateStatus,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(height * 0.03),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  int count = 0;
                                  Navigator.of(context).popUntil((_) => count++ >= 2);
                                },
                                child: Image.asset(ImageConst.backArrow)),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: Image.asset(ImageConst.closeLock)),
                            SizedBox(
                              height: height * 0.033,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: CustomLabel(
                                text: 'Reset  Password',
                                size: 21,
                                fontWeight: FontWeight.w600,
                                fontFamily: FontConst.MontserratFont,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.011,
                            ),
                            CustomPasswordField(
                              onTextChanged: _newPassController,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'New  Password is required.';
                                } else if (value.length > 15) {
                                  return 'The password must be at least 8 to 15 characters.';
                                } else {
                                  newPasswords = value.toString().trim();
                                }
                              },
                              labelText: 'New Password',
                              valueChanged: (String? value) {},
                            ),
                            SizedBox(
                              height: height * 0.025,
                            ),
                            CustomPasswordField(
                              onTextChanged: _confirmPassController,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Confirm New Password is required.';
                                }
                                if (value !=
                                    _confirmPassController.text.toString()) {
                                  return 'New Password & Confirm Password must match.';
                                } else {
                                  confirmPasswords = value.toString().trim();
                                }
                              },
                              labelText: 'Confirm New Password',
                              valueChanged: (String? value) {

                              },
                            ),
                            SizedBox(
                              height: height * 0.052,
                            ),
                            CustomRaisedButton(
                              onpressed: () async {
                                var email =
                                    await SharedPref.getString(key: 'email');
                                print("The email is $email");
                                if (_formKey.currentState!.validate()) {
                                  triggerEvent(ResetPasswordEvent(
                                      email: email,
                                      context: context,
                                      password: newPasswords,
                                      confirmPassword: confirmPasswords));
                                }
                              },
                              color: ColorConst.red,
                              text: 'Save',
                              size: 14,
                              textcolor: ColorConst.white,
                              height: height * 0.07,
                              width: width * 0.97,
                              fontsFamily: FontConst.MontserratFont,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

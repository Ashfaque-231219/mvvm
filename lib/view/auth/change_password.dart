import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redwood_app/helper/constants/asset_const.dart';
import 'package:redwood_app/helper/constants/color_const.dart';
import 'package:redwood_app/view-models/loginbloc/login_bloc.dart';
import 'package:redwood_app/view/shared_widget/loading_widget.dart';

import '../../view-models/loginbloc/login_state.dart';
import '../shared_widget/custom_label.dart';
import '../shared_widget/custom_password_filed.dart';
import '../shared_widget/custom_raised_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late String oldPasswords;
  late String newPasswords;
  late String confirmPasswords;
  final _formKey = GlobalKey<FormState>();
  TextEditingController    oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  triggerEvent(ChangePassEvent event) {
    context.read<LoginBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Scaffold(
          body: LoadingWidget(
            status: state.stateStatus,
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.090, left: 12, right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(ImageConst.backArrow)),
                        SizedBox(
                          height: height * 0.07,
                        ),
                        CustomLabel(
                          text: 'Create a New Password',
                          size: 22,
                          fontWeight: FontWeight.w500,
                          fontFamily: FontConst.MontserratFont,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomPasswordField(
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Current Password is required.';
                            } else {
                              oldPasswords = value.toString().trim();
                            }
                          },
                          labelText: 'Current Password',
                          hintText: 'Current Password',
                          onTextChanged: oldPassword,
                          valueChanged: (String? value) {
                            _formKey.currentState!.validate();

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomPasswordField(
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'New Password  is required.';
                            } else if (value.length > 15) {
                              return 'The password must be at least 8 to 15 characters.';
                            }  else {
                              newPasswords = value.toString().trim();
                            }
                          },
                          labelText: 'New Password',
                          hintText: 'New Password',
                          onTextChanged: newPassword,
                          valueChanged: (String? value) {
                            _formKey.currentState!.validate();
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomPasswordField(
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Confirm Password is required.';
                            }
                            if (value != newPassword.text.toString()) {
                              return 'New Password & Confirm Password must match.';
                            } else {
                              confirmPasswords = value.toString().trim();
                            }
                          },
                          labelText: 'Confirm Password',
                          hintText: 'Confirm Password',
                          onTextChanged: confirmPassword,
                          valueChanged: (String? value) {},
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: CustomRaisedButton(
                            text: 'Submit',
                            fontsFamily: FontConst.MontserratFont,
                            textcolor: ColorConst.white,
                            height: height * 0.07,
                            width: width * 0.97,
                            color: ColorConst.red,
                            sidecolor: Colors.white,
                            onpressed: () {
                              if (_formKey.currentState!.validate()) {
                                triggerEvent(ChangePassEvent(
                                    context: context,
                                    newPassword: newPasswords,
                                    oldPassword: oldPasswords));
                              }
                            },
                          ),
                        ),
                      ],
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

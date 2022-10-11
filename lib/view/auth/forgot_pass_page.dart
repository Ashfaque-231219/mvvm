import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redwood_app/helper/constants/asset_const.dart';
import 'package:redwood_app/helper/utils/validate.dart';
import 'package:redwood_app/view/shared_widget/custom_label.dart';

import '../../helper/constants/color_const.dart';
import '../../view-models/loginbloc/login_bloc.dart';
import '../../view-models/loginbloc/login_state.dart';
import '../shared_widget/custom_raised_button.dart';
import '../shared_widget/custom_text_field.dart';
import '../shared_widget/loading_widget.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({Key? key}) : super(key: key);

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  TextEditingController _emailController = TextEditingController();

  addEvent(ForgotPassEvent event) {
    context.read<LoginBloc>().add(event);
  }

  late String email;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Scaffold(
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
                              Navigator.pop(context);
                            },
                            child: Image.asset(ImageConst.backArrow)),
                        SizedBox(
                          height: height * 0.10,
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Image.asset(ImageConst.openLock)),
                        SizedBox(
                          height: height * 0.033,
                        ),
                        CustomLabel(
                          text: 'Need to reset your password?',
                          size: 21,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontConst.MontserratFont,
                        ),
                        SizedBox(
                          height: height * 0.011,
                        ),
                        CustomLabel(
                          text:
                              '      Resetting your password is easy.Enter \n         email ID and we\'ll send you a OTP\n                                on your email.',
                          size: 14,
                          fontFamily: FontConst.MontserratFont,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: height * 0.035,
                        ),
                        CustomTextField(
                          onTextChanged: _emailController,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required.';
                            } else if (Validate.validateEmail(
                                    value.toString()) ==
                                false) {
                              return "Email is Invalid.";
                            } else {
                              email = value.toString().trim();
                            }
                          },
                          labelText: 'Email',
                        ),
                        SizedBox(
                          height: height * 0.038,
                        ),
                        CustomRaisedButton(
                          onpressed: () {
                            if (_formKey.currentState!.validate()) {
                              addEvent(ForgotPassEvent(
                                  context: context, email: email));
                            }
                          },
                          color: ColorConst.red,
                          text: 'Send OTP',
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
        ));
      },
    );
  }
}

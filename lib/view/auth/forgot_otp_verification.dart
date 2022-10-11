import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redwood_app/helper/constants/color_const.dart';
import 'package:redwood_app/view-models/loginbloc/login_state.dart';
import 'package:redwood_app/view/shared_widget/custom_label.dart';
import 'package:redwood_app/view/shared_widget/loading_widget.dart';

import '../../helper/constants/asset_const.dart';
import '../../helper/utils/shared_pref.dart';
import '../../view-models/loginbloc/login_bloc.dart';
import '../shared_widget/custom_raised_button.dart';
import '../shared_widget/otp_input.dart';

class ForgotOtpVerification extends StatefulWidget {
  const ForgotOtpVerification({Key? key}) : super(key: key);

  @override
  State<ForgotOtpVerification> createState() => _ForgotOtpVerificationState();
}

class _ForgotOtpVerificationState extends State<ForgotOtpVerification> {
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  String _otp = '';
  var email;

  addEvent(OtpVerifyEvent event) {
    context.read<LoginBloc>().add(event);
  }

  triggerEvent(ForgotPassEvent event) {
    context.read<LoginBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Scaffold(
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SingleChildScrollView(
              child: LoadingWidget(
                status: state.stateStatus,
                child: Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.10, left: 12, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(ImageConst.backArrow)),
                      SizedBox(
                        height: height * 0.17,
                      ),
                      CustomLabel(
                        text: 'Enter verification code',
                        fontWeight: FontWeight.w800,
                        fontFamily: FontConst.MontserratFont,
                        size: 28,
                      ),
                      SizedBox(height: height * 0.015),
                      CustomLabel(
                        text:
                            'Enter the verification code below sent to your provided email address.',
                        size: 17,
                        fontFamily: FontConst.MontserratFont,
                      ),
                      SizedBox(height: height * 0.055),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OtpInput(
                            _fieldOne,
                            true,
                          ),
                          OtpInput(_fieldTwo, false),
                          OtpInput(_fieldThree, false),
                          OtpInput(_fieldFour, false)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () async {
                              email = await SharedPref.getString(key: 'email');
                              print("The email is $email");
                              triggerEvent(
                                  ForgotPassEvent(email: email.toString()));
                            },
                            child: Text(
                              'Resend OTP',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: ColorConst.red,
                                  fontFamily: FontConst.MontserratFont),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CustomRaisedButton(
                          color: ColorConst.red,
                          text: 'Proceed',
                          size: 14,
                          textcolor: ColorConst.white,
                          height: height * 0.07,
                          width: width * 0.97,
                          fontsFamily: FontConst.MontserratFont,
                          onpressed: () async {
                            setState(() {
                              _otp = _fieldOne.text +
                                  _fieldTwo.text +
                                  _fieldThree.text +
                                  _fieldFour.text;
                            });
                            email = await SharedPref.getString(key: 'email');
                            print("The eamil is ========>>>>> $email");
                            // Navigator.push(context, MaterialPageRoute(builder:(context) => ForgotPassSave()));
                            await addEvent(OtpVerifyEvent(
                                context: context,
                                otp: _otp,
                                email: email.toString()));
                          },
                        ),
                      ),
                    ],
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

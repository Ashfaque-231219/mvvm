import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redwood_app/helper/constants/asset_const.dart';
import 'package:redwood_app/helper/constants/color_const.dart';
import 'package:redwood_app/helper/utils/validate.dart';
import 'package:redwood_app/route_generator.dart';
import 'package:redwood_app/view/shared_widget/custom_label.dart';
import 'package:redwood_app/view/shared_widget/custom_text_field.dart';
import 'package:redwood_app/view/shared_widget/loading_widget.dart';

import '../../view-models/loginbloc/login_bloc.dart';
import '../../view-models/loginbloc/login_state.dart';
import '../shared_widget/custom_password_filed.dart';
import '../shared_widget/custom_raised_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool valueFirst = false;
  late String email;
  late String password;
  final _formKey = GlobalKey<FormState>();

  addEvent(LoginEvent event) {
    context.read<LoginBloc>().add(event);
  }

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit from App'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: SingleChildScrollView(
                child: LoadingWidget(
                  status: state.stateStatus,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: height * 0.16),
                            child: Image.asset(ImageConst.logImage),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          CustomLabel(
                            text: 'Please sign in to continue',
                            size: 20,
                            fontFamily: FontConst.MontserratFont,
                            fontWeight: FontWeight.w800,
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          CustomTextField(
                            onTextChanged: _emailController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required.';
                              } else if (Validate.validateEmail(value.toString()) == false) {
                                return " Invalid Email.";
                              } else {
                                email = value.toString().trim();
                              }
                            },
                            labelText: 'Email',
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          CustomPasswordField(
                            onTextChanged: _passwordController,
                            valueChanged: (String? value) {},
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required.';
                              } else if (value.length > 15) {
                                return 'Password may not be greater then 15 characters';
                              } else {
                                password = value.toString().trim();
                              }
                            },
                            labelText: 'Password',
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Row(children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: Theme(
                                  data: ThemeData(unselectedWidgetColor: Colors.grey),
                                  child: Checkbox(
                                    activeColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3.5),
                                    ),
                                    splashRadius: 0,
                                    value: valueFirst,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        valueFirst = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CustomLabel(
                                fontFamily: FontConst.MontserratFont,
                                text: 'Keep me logged in',
                                size: 13,
                                color: Colors.black54,
                              ),
                            ]),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, RoutesConst.forgotpassword).then((value) {
                                  _emailController.clear();
                                  _passwordController.clear();
                                });
                              },
                              child: CustomLabel(
                                text: 'Forgot Password?',
                                size: 13,
                                fontFamily: FontConst.MontserratFont,
                                color: ColorConst.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ]),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          CustomRaisedButton(
                            onpressed: () async {
                              if (_formKey.currentState!.validate()) {
                                addEvent(GetLoginEvent(context: context, email: email, password: password, remember: valueFirst));
                              }
                            },
                            color: ColorConst.red,
                            text: 'Login',
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
        );
      },
    );
  }


}

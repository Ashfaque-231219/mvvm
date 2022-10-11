import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:redwood_app/helper/constants/asset_const.dart';
import 'package:redwood_app/helper/constants/color_const.dart';
import 'package:redwood_app/route_generator.dart';
import 'package:redwood_app/view-models/loginbloc/login_bloc.dart';
import 'package:redwood_app/view-models/loginbloc/login_state.dart';
import 'package:redwood_app/view/auth/change_password.dart';
import 'package:redwood_app/view/shared_widget/custom_label.dart';
import 'package:redwood_app/view/shared_widget/loading_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool light = false;

  triggerEvent(logoutEvent event) {
    context.read<LoginBloc>().add(event);
  }

  getEvent(GetProfileEvent event) {
    context.read<LoginBloc>().add(event);
  }

  @override
  void initState() {
    getEvent(GetProfileEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        String? name = state.name;
        print("The name  is ==============>>>>>>> $name");
        String? email = state.email;
        String? image = state.image;
        String? date = state.date;
        print("The saved image is $image");

        return Scaffold(
            body: LoadingWidget(
          status: state.stateStatus,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22, top: 20),
                    child: CustomLabel(
                      text: "My Profile",
                      size: 17,
                      fontFamily: FontConst.MontserratFont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.060,
                  ),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Card(
                  //     elevation: 3,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child: Container(
                  //       alignment: Alignment.center,
                  //       child: Stack(alignment: Alignment.center, children: [
                  //         Padding(
                  //           padding: const EdgeInsets.only(top: 15),
                  //           child: CachedNetworkImage(
                  //             imageUrl: image.toString(),
                  //             placeholder: (context, url) =>
                  //                 const CircularProgressIndicator(),
                  //             errorWidget: (context, url, error) => const Icon(
                  //               Icons.person,
                  //               size: 100,
                  //               color: Colors.grey,
                  //             ),
                  //             height: 110,
                  //             width: 110,
                  //             fit: BoxFit.cover,
                  //           ),
                  //         ),
                  //         Positioned(
                  //             bottom: 0,
                  //             right: 0,
                  //             child: IconButton(
                  //                 onPressed: () {
                  //                   Navigator.pushNamed(
                  //                           context, RoutesConst.editProfile)
                  //                       .then((value) {
                  //                     getEvent(GetProfileEvent(context: context));
                  //                   });
                  //                 },
                  //                 icon: ImageIcon(
                  //                   AssetImage(ImageConst.editIcon),
                  //                   size: 18,
                  //                   color: ColorConst.red,
                  //                 )))
                  //       ]),
                  //       height: height * 0.17,
                  //       width: width * 0.28,
                  //     ),
                  //   ),
                  // ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.all(5),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: image != null
                                    ? CachedNetworkImage(
                                        imageUrl: image.toString(),
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.person,
                                          size: 100,
                                          color: Colors.grey,
                                        ),
                                        height: 110,
                                        width: 110,
                                        fit: BoxFit.cover,
                                      )
                                    : Container())),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          left: 65,
                          child: GestureDetector(
                              onTap: () async {
                                Navigator.pushNamed(
                                        context, RoutesConst.editProfile)
                                    .then((value) {
                                  getEvent(GetProfileEvent(context: context));
                                });
                              },
                              child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: ColorConst.red,
                                  child: ImageIcon(
                                    AssetImage(ImageConst.editIcon),
                                    size: 18,
                                    color: Colors.white,
                                  ))))
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '$name',
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        style: TextStyle(
                          fontFamily: FontConst.MontserratFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.001,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomLabel(
                      text: '$email',
                      fontFamily: FontConst.MontserratFont,
                      fontWeight: FontWeight.w100,
                      color: Colors.black,
                      size: 14,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      elevation: 7,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.settings_outlined,
                                    size: 23,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CustomLabel(
                                    text: 'Settings',
                                    size: 15,
                                    fontFamily: FontConst.MontserratFont,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: CustomLabel(
                                    text: 'Notification',
                                    size: 13,
                                    fontFamily: FontConst.MontserratFont,
                                  )),
                                  CupertinoSwitch(
                                    value: light,
                                    onChanged: (value) {
                                      light = false;
                                      setState(
                                        () {},
                                      );
                                    },
                                    thumbColor: ColorConst.white,
                                    activeColor: ColorConst.red,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Divider(
                                color: Colors.black26,
                                //color of divider
                                height: 2,
                                //height spacing of divider
                                thickness: 0.5,
                                //thickness of divier line
                                indent: 0,
                                //spacing at the start of divider
                                endIndent: 0, //spacing at the end of divider
                              ),
                              SizedBox(
                                height: height * 0.05,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: CustomLabel(
                                    text: 'Contact Admin',
                                    size: 13,
                                    fontFamily: FontConst.MontserratFont,
                                  )),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: Colors.black26,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangePassword()));
                                },
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Change Password',
                                    style: TextStyle(
                                      color: ColorConst.red,
                                      fontFamily: FontConst.MontserratFont,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.12,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Lottie.asset(
                                            'asset/images/lottie/alert.json',
                                            height: 70,
                                            width: 70),

                                        // title: const Text('Alert!',textAlign: TextAlign.center,),
                                        content: CustomLabel(
                                          text:
                                              'Are you sure you want to logout?',
                                          fontFamily: FontConst.MontserratFont,
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Yes'),
                                            onPressed: () async {
                                              triggerEvent(logoutEvent(
                                                  context: context));
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('No'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  // triggerEvent(logoutEvent(context: context));
                                },
                                child: Row(
                                  children: [
                                    ImageIcon(
                                      AssetImage(ImageConst.logoutIcon),
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: CustomLabel(
                                        text: "Logout",
                                        fontFamily: FontConst.MontserratFont,
                                      ),
                                    ),
                                    CustomLabel(
                                      text: 'App Version  1.01',
                                      fontFamily: FontConst.MontserratFont,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        color: ColorConst.white,
                        height: height * 0.5,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}

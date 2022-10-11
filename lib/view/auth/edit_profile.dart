import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redwood_app/models/user_details.dart';
import 'package:redwood_app/view-models/loginbloc/login_bloc.dart';
import 'package:redwood_app/view-models/loginbloc/login_state.dart';
import 'package:redwood_app/view/shared_widget/loading_widget.dart';

import '../../helper/constants/asset_const.dart';
import '../../helper/constants/color_const.dart';
import '../../helper/utils/utils.dart';
import '../shared_widget/custom_raised_button.dart';
import '../shared_widget/custom_text_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _image;
  late String userName = '';
  final _formKey = GlobalKey<FormState>();

  triggerEvent(UpdateProfileEvent event) {
    context.read<LoginBloc>().add(event);
  }

  triggerInfoEvent(ChangeInfoEvent event) {
    context.read<LoginBloc>().add(event);
  }

  getEvent(GetProfileEvent event) {
    context.read<LoginBloc>().add(event);
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    getEvent(GetProfileEvent(context: context));
    super.initState();
  }

  String? image;
  String? name;
  String? email;

  UserDetail? userDetail;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          name = state.name;
          print("The name is $name");
          email = state.email;
          print("The email is $email");
          image = state.image;
          print("The image is $image");
          if(_emailController.text.isEmpty){
            _emailController.text = email.toString();
          }
          if(_nameController.text.isEmpty){
            _nameController.text = name.toString();
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: LoadingWidget(
              status: state.stateStatus,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.090, left: 12, right: 12),
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
                        /* Align(
                          alignment: Alignment.center,
                          child: Card(
                            elevation: 3,
                            child: Container(
                              child:
                                  Stack(alignment: Alignment.center, children: [
                                _image == null && image != null
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
                                    : Image.file(
                                        _image!,
                                        width: 95,
                                        height: 95,
                                        fit: BoxFit.cover,
                                      ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: IconButton(
                                        onPressed: () {
                                          imagePicker(context, onPickedImage);
                                        },
                                        icon: Icon(
                                          Icons.add_a_photo,
                                          color: ColorConst.red,
                                          size: 20,
                                        )))
                              ]),
                              height: height * 0.17,
                              width: width * 0.28,
                            ),
                          ),
                        ),*/

                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  padding: const EdgeInsets.all(5),
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      child: _image == null && image != null
                                          ? CachedNetworkImage(
                                              imageUrl: image.toString(),
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                Icons.person,
                                                size: 100,
                                                color: Colors.grey,
                                              ),
                                              height: 110,
                                              width: 110,
                                              fit: BoxFit.cover,
                                            )
                                          : _image != null
                                              ? Image.file(
                                                  _image!,
                                                  width: 120,
                                                  height: 120,
                                                  fit: BoxFit.cover,
                                                )
                                              : Icon(Icons.person))),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                left: 65,
                                child: GestureDetector(
                                  onTap: () async {
                                    imagePicker(context, onPickedImage);
                                  },
                                  child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: ColorConst.red,
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: Colors.white,
                                        size: 20,
                                      )),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        /*CustomTextField(
                            onTextChanged: _nameController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Username is required.';
                              } else if (value.length > 50) {
                                return 'User name may not be greater then 50 characters';
                              } else {
                                _nameController.text = value;
                              }
                            },
                            labelText: ' Username',
                          ),*/
                        TextFormField(
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Name is required.';
                            } else if (value.length > 50) {
                              return 'Name may not be greater than 50 characters';
                            } else {
                              _nameController.text = value;
                            }
                          },
                          controller: _nameController,
                          decoration: InputDecoration(
                            errorMaxLines: 3,
                            suffixIcon:
                                ImageIcon(AssetImage(ImageConst.accountImage)),
                            fillColor: Colors.blue,
                            labelText: 'Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          readOnly: true,
                          onTextChanged: _emailController,
                          validator: (String? value) {},
                          labelText: ' email',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomRaisedButton(
                          onpressed: () async {
                            if (_image != null) {
                              if (_formKey.currentState!.validate()) {
                                triggerEvent(UpdateProfileEvent(
                                    name: _nameController.text,
                                    image: _image,
                                    context: context));
                              }
                            } else {
                              if (_formKey.currentState!.validate()) {
                                triggerEvent(UpdateProfileEvent(
                                  name: _nameController.text,
                                  context: context,
                                ));
                              }
                            }
                          },
                          color: ColorConst.red,
                          text: 'Save Changes',
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
          );
        },
      ),
    );
  }

  onPickedImage(File? img) {
    setState(() {
      print(img!.path);
      if (img != null) _image = img;
    });
  }
}

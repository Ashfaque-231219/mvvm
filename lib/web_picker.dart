
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'dart:io' as Io;
import 'dart:io';



import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redwood_app/helper/constants/asset_const.dart';
import 'package:redwood_app/view-models/loginbloc/login_bloc.dart';
import 'package:redwood_app/view-models/loginbloc/login_state.dart';

class WebPicker extends StatefulWidget {
  const WebPicker({Key? key}) : super(key: key);

  @override
  State<WebPicker> createState() => _WebPickerState();
}

class _WebPickerState extends State<WebPicker> {
  triggerEvent(UpdateProfileEvent event) {
    context.read<LoginBloc>().add(event);
  }

  File? _pickedImage;
  Uint8List webImage = Uint8List(8);

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pickedImage = selected;
          print("THe picked images if ${_pickedImage?.path}");
        });
      } else {
        print('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pickedImage = File(image.path);
        });
      } else {
        print('No image has been picked');
      }
    } else {
      print('Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Container(
                  height: 100,
                  width: 100,
                  child: _pickedImage == null
                      ? Container()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: kIsWeb
                              ? Image.memory(webImage, fit: BoxFit.fill)
                              : Image.file(_pickedImage!, fit: BoxFit.fill),
                        )),
              TextButton(
                  onPressed: () {
                    _pickImage();
                  },
                  child: Text("Choose image")),
              TextButton(
                  onPressed: () {
                    // final bytes = Io.File(_pickedImage!.path).readAsBytesSync();
                    // final bytes = Io.File(ImageConst.logoutIcon).readAsBytesSync();
                    String base64String = base64Encode(webImage);
                    print("The bytes is $base64String");


                    // triggerEvent(UpdateProfileEvent(
                    //     name: 'Shivam tiwari',
                    //     image: _pickedImage,
                    //     context: context));
                  },
                  child: Text("Submit"))
            ],
          ),
        );
      },
    );
  }
}

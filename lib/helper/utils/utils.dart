import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../constants/asset_const.dart';

Color colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Container(
        height: MediaQuery.of(context).size.width * 0.05,
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.white])),
        child: Text(
          message,
          style: TextStyle(fontFamily: FontConst.MontserratFont, fontSize: 14, fontWeight: FontWeight.w600),
        )),
    padding: EdgeInsets.zero,
    duration: const Duration(milliseconds: 1300),
  ));
}

void printLog(String text) {
  debugPrint('\x1B[33m$text\x1B[0m');
}

void printError(String text) {
  debugPrint('\x1B[31m$text\x1B[0m');
}

String formatDateToString(String datetime, String format) {
  var date = DateTime.parse(datetime == "" ? '1999-02-01 12:45:25.123456' : datetime);
  var dateformatter = DateFormat(format);
  var formatedDate = dateformatter.format(date);
  return formatedDate;
}

Future<dynamic> imagePicker(context, onTap) async {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: SizedBox(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () async {
                      var img = await _imgFromGallery();
                      Navigator.of(context).pop();
                      onTap(img);
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () async {
                    var img = await _imgFromCamera();
                    Navigator.of(context).pop();
                    onTap(img);
// return img;
                  },
                ),
              ],
            ),
          ),
        );
      });
}

Future<dynamic> _imgFromCamera() async {
  final image = await ImagePicker().getImage(source: ImageSource.camera);
  if (image == null) {
    return;
  }

  final imageTemp = File(image.path);

  if (imageTemp != null) {
    File? croppedFile = await imageCropper(imageTemp);
    if (croppedFile != null) {
      return File(croppedFile.path);
    }
  }
}

Future<dynamic> _imgFromGallery() async {
  final image = await ImagePicker().getImage(source: ImageSource.gallery);
  print('The result of image ++++++++++++++++++ $image');
  if (image == null) {
    return;
  }

  final imageTemp = File(image.path);

  if (imageTemp != null) {
    File? croppedFile = await imageCropper(imageTemp);
    if (croppedFile != null) {
      print('The result of image ++++++++++++++++++ ${croppedFile.path}');
      return File(croppedFile.path);
    }
  }
}

Future<File?> imageCropper(File imagetemp) async {
  return await ImageCropper().cropImage(
    sourcePath: imagetemp.path,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ],
    androidUiSettings: AndroidUiSettings(
      toolbarTitle: 'Cropper',
      toolbarColor: Colors.green[700],
      toolbarWidgetColor: Colors.white,
      activeControlsWidgetColor: Colors.green[700],
      initAspectRatio: CropAspectRatioPreset.original,
      lockAspectRatio: false,
    ),
    iosUiSettings: IOSUiSettings(
      minimumAspectRatio: 1.0,
    ),
  );
}

String? presentDatePicker(context, String? date) {
  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime.now()).then((pickedDate) {
    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String data = DateFormat('dd-MM-yyyy').format(pickedDate);
      print('The date is $date');
      return data;
    }
  });
}

Future<dynamic> pickImage() async {
  if (!kIsWeb) {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var selected = File(image.path);
      return selected;
      // setState(() {
      //   _pickedImage = selected;
      //   print("THe picked images if ${_pickedImage?.path}");
      // });
    } else {
      print('No image has been picked');
      return null;
    }
  } else if (kIsWeb) {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var f = await image.readAsBytes();
      return f;
      // setState(() {
      //   webImage = f;
      //   _pickedImage = File(image.path);
      // });
    } else {
      print('No image has been picked');
    }
  } else {
    print('Something went wrong');
  }
}

Future<dynamic> pickVideo() async {
  final ImagePicker _picker = ImagePicker();
  if (!kIsWeb) {
    XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      var selected = File(video.path);
      print("The selected video is ===========>>>>>>>>>>>> $selected");
      return selected;
    } else {
      print('No image has been picked');
    }
  } else {
    print('Something went wrong');
  }
}

showSheet(BuildContext ctx, Function imageFunc, Function videoFunc) {
  showModalBottomSheet(
      context: ctx,
      builder: (BuildContext bc) {
        return SafeArea(
          child: SizedBox(
            child: Wrap(
              children: <Widget>[
                ListTile(leading: const Icon(Icons.photo_library), title: const Text('Photo Library'), onTap: imageFunc()),
                ListTile(leading: const Icon(Icons.photo_camera), title: const Text('Camera'), onTap: videoFunc()),
              ],
            ),
          ),
        );
      });
}

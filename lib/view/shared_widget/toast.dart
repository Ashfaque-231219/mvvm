import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redwood_app/view/shared_widget/custom_label.dart';

class ToastMessage {
  ToastMessage.info(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.yellow,
      textColor: Colors.black,
      fontSize: 14.0,
    );
  }
  static void showToast(BuildContext context, String message, bool status) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: status ? Colors.green : Colors.red,
    ));
  }

  ToastMessage.success(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  ToastMessage.error(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  //! Simple Snackbar function
  ToastMessage.generateSnackBar(
    BuildContext context, {
    fast = false,
    required String message,
    bool isSucess = false,
    bool isInfo = false,
  }) {
    Color bgColor = isInfo
        ? Colors.yellow
        : isSucess
            ? Colors.green
            : Colors.red;
    SnackBar snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
      ),
      backgroundColor: bgColor,
      duration: Duration(milliseconds: fast ? 1000 : 3000),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //! Alert Dialog function
  ToastMessage.showAlertDialog(
    BuildContext context, {
    required String title,
    String submitText = 'Ok',
    required String message,
    required void Function()? onTap,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title.isEmpty ? null : Text(title),
          content: Text(message),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    style: ButtonStyle(
                      maximumSize: MaterialStateProperty.all(Size.infinite),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    child: CustomLabel(text: "Cancel", color: Colors.red),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        maximumSize: MaterialStateProperty.all(Size.infinite),
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      child: CustomLabel(text: '0k', color: Colors.white),
                      onPressed: onTap,
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }

//---> End ToastMessage <---
}

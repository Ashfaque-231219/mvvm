import 'package:flutter/material.dart';
import 'package:redwood_app/view/shared_widget/custom_label.dart';

class CustomExpectedDate extends StatelessWidget {
  final bool visible;
  final String text;
  final String date;
  const CustomExpectedDate({Key? key,required this.visible,required this.date,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomLabel(text: text),
          Padding(
              padding: const EdgeInsets.only(right: 40),
              child: CustomLabel(text: date)),
        ],
      ),
    );
  }
}

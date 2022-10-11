import 'package:flutter/material.dart';
import 'package:redwood_app/helper/constants/asset_const.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.onTextChanged,
    this.readonly = false,
    required this.validator,
    this.hintText = '',
    this.labelText = '',
    this.readOnly = false,
    this.visibleIcon = true,
    this.maxLength,
    this.maxLines,
    this.expands = false,
    this.inputType = TextInputType.text,
    this.onChanged,
    Key? key,
  }) : super(key: key);
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final TextEditingController onTextChanged;
  final bool readonly;
  final String labelText;
  final String hintText;
  final bool readOnly;
  final bool visibleIcon;
  final TextInputType inputType;
  final int? maxLength;
  final int? maxLines;
  final bool expands;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  get labelText => widget.labelText;

  get hintText => widget.hintText;

  get onTextChanged => widget.onTextChanged;

  get validatorFunc => widget.validator;

  get onChanged => widget.onChanged;

  get readOnly => widget.readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      textAlignVertical: TextAlignVertical.top,
      expands: widget.expands,
      keyboardType: widget.inputType,
      validator: validatorFunc,
      controller: widget.onTextChanged,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      readOnly: widget.readOnly,
      decoration: widget.visibleIcon?
      InputDecoration(
        isDense: true,
        errorMaxLines: 3,
        suffixIcon: ImageIcon(AssetImage(ImageConst.accountImage)),
        fillColor: Colors.blue,
        labelText: widget.labelText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.grey,
            )),
      ) :InputDecoration(
        isDense: true,
        errorMaxLines: 3,
        fillColor: Colors.blue,
        labelText: widget.labelText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.grey,
            )),
      ),
    );
  }
}

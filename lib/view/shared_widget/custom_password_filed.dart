import 'package:flutter/material.dart';


class CustomPasswordField extends StatefulWidget {
  const CustomPasswordField({
    required this.validator,
    this.labelText = '',
    this.hintText = '',
    required this.onTextChanged,
    required this.valueChanged,
    Key? key,
  }) : super(key: key);
  final String? Function(String?)? validator;
  final String? Function(String?)? valueChanged;
  final String labelText;
  final String hintText;
  final TextEditingController onTextChanged;

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool secureText = true;

  get labelText => widget.labelText;

  get hintText => widget.hintText;

  get onTextChanged => widget.onTextChanged;

  get secureTexts => secureText;

  get validatorfunc => widget.validator;
  get onChanged => widget.valueChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,

      validator: validatorfunc,
      obscureText: secureTexts,
      controller: widget.onTextChanged,
      decoration: InputDecoration(
          errorMaxLines: 3,
          fillColor: Colors.blue,
          label: Text(widget.labelText),
          hintText: widget.hintText,
          border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
            color: Colors.grey,
          )),
          suffixIcon: InkWell(
            onTap: _togglePasswordView,
            child: Icon(secureTexts
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,color: Colors.grey,),

          )),
    );
  }

  void _togglePasswordView() {
    setState(() {
      secureText = !secureTexts;
    });
  }
}

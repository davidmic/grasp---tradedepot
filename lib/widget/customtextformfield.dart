import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;
  final IconData icon;
  final double iconSize;
  final String hintText;
  final bool obsecureText;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final bool useLabel;
  final String label;
  final bool useSuffixIcon;
  final Widget suffixIcon;
  final int maxLength;

  CustomTextFormField({
    this.onSaved,
    this.validator,
    this.hintText,
    this.iconSize,
    this.icon,
    this.inputFormatters,
    this.obsecureText = false,
    this.keyboardType,
    this.useLabel = false,
    this.label,
    this.useSuffixIcon = false,
    this.suffixIcon,
    this.maxLength,
});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      maxLength: maxLength,
      onSaved: onSaved,
      validator: validator,
      inputFormatters: inputFormatters,
      obscureText: obsecureText,
      decoration: InputDecoration(
        labelText: useLabel ? label : null,
        prefixIcon: Icon(
          icon,
          size: iconSize,
        ),
        suffixIcon: useSuffixIcon ? suffixIcon : null,
        hintText: hintText,
      ),
    );
  }
}

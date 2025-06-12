import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final String txt;
  final Icon icn;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool isPassword;

  const CustomFormField({
    required this.icn,
    required this.txt,
    this.validator,
    this.controller,
    this.isPassword = false,
    super.key,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 12),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : false,
        decoration: InputDecoration(
          prefixIcon: widget.icn,
          hintText: widget.txt,
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : null,
        ),
        validator: widget.validator,
      ),
    );
  }
}
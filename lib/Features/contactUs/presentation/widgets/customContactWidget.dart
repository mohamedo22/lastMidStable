import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Customcontactwidget extends StatelessWidget {
  final String txt;
  final Icon icn;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  Customcontactwidget({
    required this.icn,
    required this.txt,
    this.validator,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: icn,
          hintText: txt,
        ),
        validator: validator,
      ),
    );
  }
}

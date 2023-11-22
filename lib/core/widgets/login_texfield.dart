// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final controller; 
  final String hinText;
  final bool obscureText;
  const LoginTextField({
    Key? key,
    required this.controller,
    required this.hinText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 25.0),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder:
                 OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade400)),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hinText,
            hintStyle: TextStyle(color: Colors.grey[500])
          ),
        ));
  }
}

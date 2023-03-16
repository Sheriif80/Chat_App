import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({this.onchanged, this.hintText, this.hidden = false});

  Function(String)? onchanged;

  bool? hidden;

  String? hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        obscureText: hidden!,
        validator: (data) {
          if (data!.isEmpty) {
            return "Can't be empty";
          }
        },
        onChanged: onchanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.7,
              color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.7,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';


class TextFieldBox extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool isObscure;
  final IconData icon;
  const TextFieldBox ({super.key, required this.hint, required this.controller, required this.icon, this.isObscure=false });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      validator: (value){
        if (value == null || value.isEmpty){
          return " $hint is missing!";
        }
        return null;
      },
      obscureText: isObscure,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
        filled: true,
        fillColor: Colors.grey[900],
        prefixIcon: Icon(icon,color: Colors.grey.withOpacity(0.5),),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),);
  }
}



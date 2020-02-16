import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscure;

  InputField({this.icon, this.hint, this.obscure});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white, width: 0.5))),
      child: TextFormField(
        obscureText: this.obscure,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            icon: Icon(
              this.icon,
              color: Colors.white,
            ),
            border: InputBorder.none,
            hintText: this.hint,
            hintStyle: TextStyle(color: Colors.white, fontSize: 15),
            contentPadding:
                EdgeInsets.only(top: 30, right: 30, bottom: 30, left: 5)),
      ),
    );
  }
}

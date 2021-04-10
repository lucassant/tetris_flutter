import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Icon icon;
  final Function() function;

  const ActionButton({Key? key, required this.icon, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            elevation: 0,
          ),
          onPressed: function,
          child: icon),
    );
  }
}

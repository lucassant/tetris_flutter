import 'package:flutter/material.dart';
import 'package:tetromi/util/constants.dart';

class UserInput extends StatelessWidget {
  final Function onActionButtonPressed;

  const UserInput({Key? key, required this.onActionButtonPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  onActionButtonPressed(LastButtonPressed.LEFT);
                },
                child: Icon(Icons.arrow_left)),
            ElevatedButton(
                onPressed: () {
                  onActionButtonPressed(LastButtonPressed.RIGHT);
                },
                child: Icon(Icons.arrow_right)),
          ],
        ),
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  onActionButtonPressed(LastButtonPressed.ROTATE_LEFT);
                },
                child: Icon(Icons.rotate_left)),
            ElevatedButton(
                onPressed: () {
                  onActionButtonPressed(LastButtonPressed.ROTATE_RIGHT);
                },
                child: Icon(Icons.rotate_right)),
          ],
        ),
      ],
    );
  }
}

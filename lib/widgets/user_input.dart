import 'package:flutter/material.dart';
import 'package:tetromi/util/colors_app.dart';
import 'package:tetromi/util/constants.dart';
import 'package:tetromi/widgets/action_button.dart';

class UserInput extends StatelessWidget {
  final Function onActionButtonPressed;

  const UserInput({Key? key, required this.onActionButtonPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: GAME_WIDTH,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ActionButton(
            icon: Icon(
              Icons.rotate_left,
              color: COR_BACKGROUND,
              size: 30,
            ),
            function: () {
              onActionButtonPressed(LastButtonPressed.ROTATE_LEFT);
            },
          ),
          ActionButton(
            icon: Icon(
              Icons.arrow_left,
              color: COR_BACKGROUND,
              size: 40,
            ),
            function: () {
              onActionButtonPressed(LastButtonPressed.LEFT);
            },
          ),
          ActionButton(
            icon: Icon(
              Icons.arrow_right,
              color: COR_BACKGROUND,
              size: 40,
            ),
            function: () {
              onActionButtonPressed(LastButtonPressed.RIGHT);
            },
          ),
          ActionButton(
            icon: Icon(
              Icons.rotate_right,
              color: COR_BACKGROUND,
              size: 30,
            ),
            function: () {
              onActionButtonPressed(LastButtonPressed.ROTATE_RIGHT);
            },
          ),
        ],
      ),
    );
  }
}

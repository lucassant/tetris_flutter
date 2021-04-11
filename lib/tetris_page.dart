import 'package:flutter/material.dart';
import 'package:tetromi/util/colors_app.dart';
import 'package:tetromi/widgets/game_widget.dart';

class TetrisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COR_BACKGROUND,
      body: SafeArea(child: GameWidget()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tetromi/util/colors_app.dart';
import 'package:tetromi/widgets/game.dart';

class TetrisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COR_BACKGROUND,
      body: SafeArea(child: GameWidget()),
    );
  }
}

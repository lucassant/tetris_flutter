import 'package:flutter/material.dart';
import 'package:tetromi/widgets/game.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Game'),
        centerTitle: true,
      ),
      body: GameWidget(),
    );
  }
}

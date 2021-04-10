import 'package:flutter/material.dart';
import 'package:tetromi/util/colors_app.dart';

class ScoreDisplay extends StatelessWidget {
  final int score;

  const ScoreDisplay({Key? key, required this.score}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 70,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: COR_BACKGROUND,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 2, color: Colors.white)),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Score',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '$score',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

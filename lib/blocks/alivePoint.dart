import 'package:flutter/material.dart';
import 'package:tetromi/blocks/point.dart';

class AlivePoint extends Point {
  late Color color;

  AlivePoint(int x, int y, this.color) : super(x, y);

  bool checkIfPointsCollide(List<Point> pointList) {
    bool retValue = false;

    pointList.forEach((p) {
      if (p.x == x && p.y == y - 1) {
        retValue = true;
      }
    });

    return retValue;
  }
}

import 'package:flutter/material.dart';
import 'package:tetromi/blocks/block.dart';
import 'package:tetromi/blocks/point.dart';

class LBlock extends Block {
  LBlock(int width) {
    points[0] = Point((width / 2 - 1).floor(), 0);
    points[1] = Point((width / 2 + 0).floor(), 0);
    points[2] = Point((width / 2 + 1).floor(), 0);
    points[3] = Point((width / 2 + 1).floor(), -1);
    rotationCenter = points[1];
    color = Colors.purple;
  }
}

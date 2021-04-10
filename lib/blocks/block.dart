import 'package:flutter/material.dart';

import 'package:tetromi/util/constants.dart';
import 'package:tetromi/blocks/point.dart';

class Block {
  List<Point> points = List<Point>.filled(4, Point(0, 0));
  late Point rotationCenter;
  Color? color;

  void move(MoveDir dir) {
    switch (dir) {
      case MoveDir.LEFT:
        if (canMoveToSide(-1)) {
          points.forEach((p) => p.x -= 1);
        }

        break;
      case MoveDir.RIGHT:
        if (canMoveToSide(1)) {
          points.forEach((p) => p.x += 1);
        }

        break;
      case MoveDir.DOWN:
        points.forEach((p) => p.y += 1);
        break;
    }
  }

  bool allPointsInside() {
    bool retVal = true;

    points.forEach((p) {
      if (p.x < 0 || p.x >= BOARD_WIDTH) {
        retVal = false;
      }
    });

    return retVal;
  }

  void rotateRight() {
    points.forEach((point) {
      int x = point.x;
      point.x = rotationCenter.x - point.y + rotationCenter.y;
      point.y = rotationCenter.y + x - rotationCenter.x;
    });

    if (!allPointsInside()) {
      rotateLeft();
    }
  }

  void rotateLeft() {
    points.forEach((point) {
      int x = point.x;
      point.x = rotationCenter.x + point.y - rotationCenter.y;
      point.y = rotationCenter.y - x + rotationCenter.x;
    });

    if (!allPointsInside()) {
      rotateRight();
    }
  }

  bool canMoveToSide(int moveAmt) {
    bool retVal = true;

    points.forEach((p) {
      if (p.x + moveAmt < 0 || p.x + moveAmt >= BOARD_WIDTH) {
        retVal = false;
      }
    });

    return retVal;
  }

  bool isAtBottom() {
    int lowestPoint = 0;

    points.forEach((p) {
      if (p.y > lowestPoint) {
        lowestPoint = p.y;
      }
    });

    if (lowestPoint >= BOARD_HEIGHT - 1) {
      return true;
    }

    return false;
  }
}

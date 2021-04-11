import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:tetromi/util/constants.dart';
import 'package:tetromi/util/helper.dart';

import 'blocks/blocks_export.dart';

class GameController extends ChangeNotifier {
  ValueNotifier<LastButtonPressed> performAction =
      ValueNotifier(LastButtonPressed.NONE);

  ValueNotifier<Block> currentBlock = ValueNotifier(getRandomBlock());
  ValueNotifier<Block> nextBlock = ValueNotifier(getRandomBlock());

  late Timer timer;

  List<AlivePoint> alivePoints = [];
  ValueNotifier<int> score = ValueNotifier(0);
  ValueNotifier<int> gameTime = ValueNotifier(0);

  GameController() {
    startGame();
  }

  void startGame() {
    timer = Timer.periodic(Duration(milliseconds: GAME_SPEED), onTimerTick);
  }

  void onTimerTick(Timer tm) {
    gameTime.value++;

    if (playerLost()) {
      if (tm.isActive) tm.cancel();
      return;
    }
    removeFullRow();

    if (currentBlock.value.isAtBottom() || isAboveOldBlock()) {
      saveOldBlock();

      currentBlock.value = nextBlock.value;
      nextBlock.value = getRandomBlock();
    }

    currentBlock.value.move(MoveDir.DOWN);
  }

  void removeRow(int row) {
    alivePoints.removeWhere((element) => element.y == row);

    alivePoints.forEach((p) {
      if (p.y < row) {
        p.y += 1;
      }
    });

    score.value++;
  }

  void removeFullRow() {
    for (int currentRow = 0; currentRow < BOARD_HEIGHT; currentRow++) {
      // loop through all rows (top to bottom)
      int counter = 0;

      alivePoints.forEach((p) {
        if (p.y == currentRow) {
          counter++;
        }
      });

      if (counter == BOARD_WIDTH) {
        // remove current row
        removeRow(currentRow);
      }
    }
  }

  bool playerLost() {
    bool retVal = false;

    alivePoints.forEach((p) {
      if (p.y <= 0) {
        retVal = true;
      }
    });

    return retVal;
  }

  void saveOldBlock() {
    currentBlock.value.points.forEach((p) {
      AlivePoint newPoint = AlivePoint(p.x, p.y, currentBlock.value.color!);
      alivePoints.add(newPoint);
    });
  }

  bool isAboveOldBlock() {
    bool retVal = false;

    alivePoints.forEach((old) {
      if (old.checkIfPointsCollide(currentBlock.value.points)) {
        retVal = true;
      }
    });

    return retVal;
  }

  void onActionButtonPressed(LastButtonPressed newAction) {
    performAction.value = newAction;

    if (performAction.value != LastButtonPressed.NONE) {
      switch (performAction.value) {
        case LastButtonPressed.LEFT:
          currentBlock.value.move(MoveDir.LEFT);
          break;
        case LastButtonPressed.RIGHT:
          currentBlock.value.move(MoveDir.RIGHT);
          break;
        case LastButtonPressed.ROTATE_LEFT:
          currentBlock.value.rotateLeft();
          break;
        case LastButtonPressed.ROTATE_RIGHT:
          currentBlock.value.rotateRight();
          break;
        default:
          break;
      }
    }

    performAction.value = LastButtonPressed.NONE;
  }
}

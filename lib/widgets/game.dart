import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tetromi/blocks/alivePoint.dart';
import 'package:tetromi/blocks/block.dart';
import 'package:tetromi/util/colors_app.dart';
import 'package:tetromi/util/constants.dart';
import 'package:tetromi/util/helper.dart';
import 'package:tetromi/widgets/next_block.dart';
import 'package:tetromi/widgets/score_display.dart';
import 'package:tetromi/widgets/user_input.dart';

class GameWidget extends StatefulWidget {
  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  LastButtonPressed performAction = LastButtonPressed.NONE;
  Block? currentBlock;
  Block? nextBlock;
  late Timer timer;
  List<AlivePoint> alivePoints = [];
  int score = 0;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void onActionButtonPressed(LastButtonPressed newAction) {
    setState(() {
      performAction = newAction;

      if (performAction != LastButtonPressed.NONE) {
        switch (performAction) {
          case LastButtonPressed.LEFT:
            currentBlock?.move(MoveDir.LEFT);
            break;
          case LastButtonPressed.RIGHT:
            currentBlock?.move(MoveDir.RIGHT);
            break;
          case LastButtonPressed.ROTATE_LEFT:
            currentBlock?.rotateLeft();
            break;
          case LastButtonPressed.ROTATE_RIGHT:
            currentBlock?.rotateRight();
            break;
          default:
            break;
        }
      }

      performAction = LastButtonPressed.NONE;
    });
  }

  void _startGame() {
    setState(() {
      currentBlock = getRandomBlock();
      nextBlock = getRandomBlock();
    });

    timer = new Timer.periodic(
      new Duration(milliseconds: GAME_SPEED),
      onTimeTIck,
    );
  }

  void saveOldBlock() {
    currentBlock?.points.forEach((p) {
      AlivePoint newPoint = AlivePoint(p.x, p.y, currentBlock!.color!);
      setState(() {
        alivePoints.add(newPoint);
      });
    });
  }

  bool isAboveOldBlock() {
    bool retVal = false;

    alivePoints.forEach((old) {
      if (old.checkIfPointsCollide(currentBlock!.points)) {
        retVal = true;
      }
    });

    return retVal;
  }

  void removeRow(int row) {
    setState(() {
      alivePoints.removeWhere((element) => element.y == row);

      alivePoints.forEach((p) {
        if (p.y < row) {
          p.y += 1;
        }
      });

      score++;
    });
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

  void onTimeTIck(Timer time) {
    if (currentBlock == null || playerLost()) {
      timer.cancel();
      return;
    }

    removeFullRow();

    if (currentBlock!.isAtBottom() || isAboveOldBlock()) {
      saveOldBlock();

      setState(() {
        currentBlock = nextBlock;
        nextBlock = getRandomBlock();
      });
    }

    setState(() {
      currentBlock?.move(MoveDir.DOWN);
    });
  }

  Widget? drawTetrisBlocks() {
    if (currentBlock == null) return null;

    List<Positioned> visiblePoints = [];

    currentBlock?.points.forEach((p) {
      Positioned newPoint = Positioned(
        child: getTetrisPoint(currentBlock!.color!),
        left: p.x * POINT_SIZE,
        top: p.y * POINT_SIZE,
      );

      visiblePoints.add(newPoint);
    });

    // old blocks
    alivePoints.forEach((point) {
      visiblePoints.add(Positioned(
        child: getTetrisPoint(point.color),
        left: point.x * POINT_SIZE,
        top: point.y * POINT_SIZE,
      ));
    });

    return Stack(
      children: visiblePoints,
    );
  }

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScoreDisplay(score: score),
              SizedBox(
                width: 10,
              ),
              NextBlock(
                nextBlock: nextBlock ?? Block(),
              ),
            ],
          ),
          Container(
            width: GAME_WIDTH,
            height: GAME_HEIGHT,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(4),
                color: COR_BACKGROUND),
            child: playerLost() ? getGameOverText(score) : drawTetrisBlocks(),
          ),
          UserInput(onActionButtonPressed: onActionButtonPressed)
        ],
      ),
    );
  }
}

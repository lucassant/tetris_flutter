import 'package:flutter/material.dart';
import 'package:tetromi/blocks/block.dart';
import 'package:tetromi/game_controller.dart';
import 'package:tetromi/util/colors_app.dart';
import 'package:tetromi/util/constants.dart';
import 'package:tetromi/util/helper.dart';
import 'package:tetromi/widgets/score_display.dart';
import 'package:tetromi/widgets/user_input.dart';

import 'next_block.dart';

class GameWidget extends StatelessWidget {
  final GameController controller = new GameController();

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
              ValueListenableBuilder<int>(
                valueListenable: controller.score,
                builder: (context, value, child) => ScoreDisplay(score: value),
              ),
              SizedBox(
                width: 10,
              ),
              ValueListenableBuilder<Block>(
                valueListenable: controller.nextBlock,
                builder: (context, value, child) => NextBlock(nextBlock: value),
              )
            ],
          ),
          Container(
            width: GAME_WIDTH,
            height: GAME_HEIGHT,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(4),
                color: COR_BACKGROUND),
            child: ValueListenableBuilder<int>(
                valueListenable: controller.gameTime,
                builder: (context, value, child) {
                  if (controller.playerLost()) {
                    return getGameOverText(controller.score.value);
                  }

                  return ValueListenableBuilder(
                    valueListenable: controller.performAction,
                    builder: (context, value, child) => drawTetrisBlocks(),
                  );
                }),
          ),
          UserInput(onActionButtonPressed: controller.onActionButtonPressed)
        ],
      ),
    );
  }

  Widget drawTetrisBlocks() {
    List<Positioned> visiblePoints = [];

    controller.currentBlock.value.points.forEach((p) {
      Positioned newPoint = Positioned(
        child: getTetrisPoint(controller.currentBlock.value.color!),
        left: p.x * POINT_SIZE,
        top: p.y * POINT_SIZE,
      );

      visiblePoints.add(newPoint);
    });

    // old blocks
    controller.alivePoints.forEach((point) {
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
}

import 'package:flutter/material.dart';
import 'package:tetromi/blocks/block.dart';
import 'package:tetromi/blocks/blocks_export.dart';
import 'package:tetromi/util/colors_app.dart';

class NextBlock extends StatelessWidget {
  final Block nextBlock;

  const NextBlock({Key? key, required this.nextBlock}) : super(key: key);
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
              'Next',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: getBlockImage(),
            ),
          ),
        ],
      ),
    );
  }

  Image getBlockImage() {
    if (nextBlock is IBlock) {
      return Image.asset(
        'assets/images/iblock.png',
        fit: BoxFit.cover,
        width: 100,
        height: 60,
      );
    }

    if (nextBlock is JBlock) {
      return Image.asset(
        'assets/images/jblock.png',
        fit: BoxFit.cover,
        width: 100,
        height: 60,
      );
    }

    if (nextBlock is LBlock) {
      return Image.asset(
        'assets/images/lblock.png',
        fit: BoxFit.cover,
        width: 100,
        height: 60,
      );
    }

    if (nextBlock is OBlock) {
      return Image.asset(
        'assets/images/oblock.png',
        fit: BoxFit.cover,
        width: 100,
        height: 60,
      );
    }

    if (nextBlock is SBlock) {
      return Image.asset(
        'assets/images/sblock.png',
        fit: BoxFit.cover,
        width: 100,
        height: 60,
      );
    }

    if (nextBlock is TBlock) {
      return Image.asset(
        'assets/images/tblock.png',
        fit: BoxFit.cover,
        width: 100,
        height: 60,
      );
    }

    return Image.asset(
      'assets/images/zblock.png',
      fit: BoxFit.cover,
      width: 100,
      height: 60,
    );
  }
}

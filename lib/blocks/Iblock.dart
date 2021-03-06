import 'package:tetromi/blocks/block.dart';
import 'package:tetromi/blocks/point.dart';
import 'package:tetromi/util/colors_app.dart';

class IBlock extends Block {
  IBlock(int width) {
    points[0] = Point((width / 2 - 2).floor(), -1);
    points[1] = Point((width / 2 - 1).floor(), -1);
    points[2] = Point((width / 2 - 0).floor(), -1);
    points[3] = Point((width / 2 + 1).floor(), -1);
    rotationCenter = points[1];
    color = COR_IBLOCK;
  }
}

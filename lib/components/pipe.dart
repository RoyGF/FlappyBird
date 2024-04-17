import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flappy_bird/core/asset_routes.dart';
import 'package:flappy_bird/core/game_configuration.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';

enum PipeType { top, bottom }

class Pipe extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  Pipe({
    required this.pipeType,
    required this.height,
  });

  @override
  final double height;
  final PipeType pipeType;

  @override
  FutureOr<void> onLoad() async {
    final pipe = await Flame.images.load(AssetRoutes.pipe);
    final rotatedPipe = await Flame.images.load(AssetRoutes.pipeRotated);

    size = Vector2(50, height);

    switch (pipeType) {
      case PipeType.top:
        position.y = 0;
        sprite = Sprite(rotatedPipe);
        break;
      case PipeType.bottom:
        position.y = gameRef.size.y - size.y - Config.groundHeight;
        sprite = Sprite(pipe);
        break;
    }

    add(RectangleHitbox());
  }
}

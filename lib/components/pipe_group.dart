import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/core/asset_routes.dart';
import 'package:flappy_bird/core/game_configuration.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  PipeGroup();

  @override
  FutureOr<void> onLoad() {
    position.x = gameRef.size.x;

    final double heightMinusGround = gameRef.size.y - Config.groundHeight + 30;
    const double spacing = Config.pipesSpacing;
    final centerY =
        spacing + Random().nextDouble() * (heightMinusGround - spacing);

    final List<Pipe> pipes = [
      Pipe(
        pipeType: PipeType.top,
        height: centerY - spacing / 2,
      ),
      Pipe(
        pipeType: PipeType.bottom,
        height: heightMinusGround - (centerY + spacing / 2),
      ),
    ];

    addAll(pipes);
  }

  void updateScore() {
    gameRef.bird.score += 1;
    FlameAudio.play(AssetRoutes.point);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Config.gameSpeed * dt;

    if (position.x <= -10) {
      removeFromParent();
      updateScore();
    }

    if (gameRef.isHit) {
      removeFromParent();
      gameRef.isHit = false;
    }
  }
}

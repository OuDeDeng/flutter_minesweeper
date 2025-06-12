import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:minesweeper/core/tools/localizations.dart';
import 'package:minesweeper/l10n/localizations/app_localizations.dart';
import 'package:minesweeper/services/algorithm/service.dart';

enum GameStatus {
  running,
  win,
  lose,
}

class HomeState extends GetxController {
  final status = GameStatus.running.obs;
  final result = "".obs;
  final board = <Point>[].obs;
  final columnCount = 10;
  final mineCount = 30;

  @override
  void onInit() {
    super.onInit();
    AlgorithmService().columnCount = columnCount;
    AlgorithmService().rowCount = columnCount;
    reset();
  }

  void tapItem(BuildContext context, int index) {
    if (AlgorithmService().firstTapIndex < 0) {
      AlgorithmService().firstTapIndex = index;
      final points = AlgorithmService().generateBoard(mineCount);
      AlgorithmService().floodFill(points, index);
      board.clear();
      board.addAll(points);
      AlgorithmService().startDurationTimer();
      result.value = AppLocalizations.of(context)!.gameRunning;
    } else {
      final point = board[index];
      if (point.value == 9) {
        point.clicked = true;
        board.refresh();
        status.value = GameStatus.lose;
        result.value = AppLocalizations.of(context)!.gameLose;
        AlgorithmService().stopDurationTimer();
        return;
      } else {
        AlgorithmService().floodFill(board, index);
        board.refresh();
      }
    }
    final p = board.firstWhereOrNull((e) => e.clicked == false && e.value != 9);
    if (p == null) {
      status.value = GameStatus.win;
      result.value = AppLocalizations.of(context)!.gameWin;
      AlgorithmService().stopDurationTimer();
    }
  }

  void reset() {
    AlgorithmService().firstTapIndex = -1;
    final points = AlgorithmService().resetBoard();
    board.clear();
    board.addAll(points);
    status.value = GameStatus.running;
    result.value = appLocalizationsNoContext().gameRunning;
    AlgorithmService().stopDurationTimer();
  }
}

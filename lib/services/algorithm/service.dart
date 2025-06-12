import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:minesweeper/services/event_bus/service.dart';

class Point {
  int value;
  bool clicked;

  Point({
    this.value = 0,
    this.clicked = false,
  });
}

class AlgorithmService {
  static final AlgorithmService _singleton = AlgorithmService._internal();

  factory AlgorithmService() => _singleton;

  AlgorithmService._internal();

  // 排除第一个点击的位置，避免第一次点击就 "Game Over" 的情况
  var firstTapIndex = -1;
  var rowCount = 0;
  var columnCount = 0;

  List<Point> resetBoard() {
    firstTapIndex = -1;
    return List.filled(rowCount * columnCount, Point(value: 0)).toList();
  }

  List<Point> generateBoard(int mineCount) {
    final board = _randomMines(rowCount, columnCount, mineCount);
    _shuffleMines(board);
    final points = board.map((value) => Point(value: value)).toList();
    _traverseNeighbor(points);
    return points;
  }

  List<int> _randomMines(int rowCount, int columnCount, int mineCount) {
    // assert
    assert(rowCount >= 0);
    assert(columnCount >= 0);
    final total = rowCount * columnCount;
    assert(mineCount < total);
    final board = List.filled(mineCount, 9).toList();
    final blanks = List.filled(total - mineCount, 0);
    board.addAll(blanks);
    if (board[firstTapIndex] != 0) {
      final firstZero = board.indexOf(0);
      board.swap(firstZero, firstTapIndex);
    }
    return board;
  }

  void _shuffleMines(List<int> board) {
    // 洗牌法
    final random = Random();
    final length = board.length;
    for (var i = 0; i < board.length; i++) {
      final point = random.nextInt(length);
      if (i == firstTapIndex || point == firstTapIndex) {
        continue;
      }
      board.swap(i, point);
    }
  }

  // 计算相邻雷的数量
  void _traverseNeighbor(List<Point> points) {
    for (var i = 0; i < points.length; i++) {
      final point = points[i];
      if (point.value == 9) {
        final row = (i / columnCount).toInt();
        final column = i % columnCount;
        _increaseValue(points, row - 1, column - 1);
        _increaseValue(points, row - 1, column);
        _increaseValue(points, row - 1, column + 1);
        _increaseValue(points, row, column - 1);
        _increaseValue(points, row, column + 1);
        _increaseValue(points, row + 1, column - 1);
        _increaseValue(points, row + 1, column);
        _increaseValue(points, row + 1, column + 1);
      }
    }
  }

  void _increaseValue(List<Point> points, int row, int column) {
    if (row < 0 || row >= rowCount || column < 0 || column >= columnCount) {
      return;
    }
    final index = columnCount * row + column;
    final point = points[index];
    if (point.value != 9) {
      point.value += 1;
    }
  }

  void floodFill(List<Point> points, int index) {
    final row = (index / columnCount).toInt();
    final column = index % columnCount;
    _mark(points, row, column);
  }

  void _mark(List<Point> points, int row, int column) {
    if (row < 0 || row >= rowCount || column < 0 || column >= columnCount) {
      return;
    }
    final index = columnCount * row + column;
    final point = points[index];
    if (point.value == 9) {
      return;
    }
    if (point.clicked) {
      return;
    }
    point.clicked = true;

    // top
    _mark(points, row - 1, column);
    // bottom
    _mark(points, row + 1, column);
    // left
    _mark(points, row, column - 1);
    // right
    _mark(points, row, column + 1);
  }

  Timer? _timer;
  var _startTime = DateTime.now();

  Future<void> startDurationTimer() async {
    stopDurationTimer();
    _startTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (_) => _updateDuration());
  }

  void stopDurationTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _updateDuration() {
    final now = DateTime.now();
    final duration = now.difference(_startTime);
    final locale = DurationLocale.fromLanguageCode(_languageCode) ??
        EnglishDurationLocale();
    final text = duration.pretty(locale: locale);
    final eventBus = Get.find<AppEventBus>();
    eventBus.updateDuration(text);
  }

  String get _languageCode {
    final binding = WidgetsFlutterBinding.ensureInitialized();
    final locale = binding.platformDispatcher.locale;
    return locale.languageCode;
  }
}

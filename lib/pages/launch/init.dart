import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper/services/event_bus/service.dart';
import 'package:minesweeper/services/music/service.dart';

Future<void> initApp(BuildContext context) async {
  _initGetX();
  await _initService();
}

void _initGetX() {
  Get.put(AppEventBus());
}

Future<void> _initService() async {
  await MusicService().asyncInit();
}

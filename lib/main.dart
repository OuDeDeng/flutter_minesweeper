import 'package:flutter/material.dart';
import 'package:minesweeper/pages/main/router.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (UniversalPlatform.isDesktop) {
    await windowManager.ensureInitialized();

    const windowSize = Size(400, 600);
    // mac store
    // const windowSize = Size(1168, 688);
    WindowOptions windowOptions = WindowOptions(
      size: windowSize,
      minimumSize: windowSize,
      center: true,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(GoRouteApp());
}

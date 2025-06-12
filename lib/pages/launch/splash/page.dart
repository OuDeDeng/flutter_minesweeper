import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minesweeper/pages/launch/init.dart';
import 'package:minesweeper/pages/main/url.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  @override
  void initState() {
    _initRouter();
    super.initState();
  }

  Future<void> _initRouter() async {
    await initApp(context);
    if (mounted) {
      context.go(RouterPath.home.name);
    }
  }
}

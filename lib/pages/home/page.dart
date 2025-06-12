import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper/l10n/localizations/app_localizations.dart';
import 'package:minesweeper/pages/color/manager.dart';
import 'package:minesweeper/pages/home/state.dart';
import 'package:minesweeper/services/event_bus/service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeState>(
      init: HomeState(),
      builder: (state) => Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.homePageTitle),
          actions: [
            IconButton(
              onPressed: () => state.reset(),
              icon: Icon(Icons.refresh),
            )
          ],
        ),
        body: SafeArea(
          child: _body(context, state),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, HomeState state) {
    return Column(
      children: [
        _header(context, state),
        Expanded(
          child: Obx(() => _board(context, state)),
        ),
        Obx(() => _gameResult(context, state)),
      ],
    );
  }

  Widget _header(BuildContext context, HomeState state) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Icon(
                Icons.timer,
                color: Theme.of(context).primaryColor,
              ),
              Obx(() => _duration(context, state)),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.flag,
                color: Theme.of(context).primaryColor,
              ),
              Text("${state.mineCount}"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _duration(BuildContext context, HomeState state) {
    final eventBus = Get.find<AppEventBus>();
    return Text(eventBus.duration.value);
  }

  Widget _board(BuildContext context, HomeState state) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: state.columnCount),
      itemBuilder: (ctx, index) => Obx(() => _cell(context, index, state)),
      itemCount: state.board.length,
    );
  }

  Widget _cell(BuildContext context, int index, HomeState state) {
    final point = state.board[index];
    if (point.clicked) {
      if (point.value == 0) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorManager.border(context),
            ),
            color: ColorManager.itemClicked(context),
          ),
        );
      } else if (point.value == 9) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorManager.border(context),
            ),
            color: ColorManager.mine,
          ),
          child: Center(
            child: Text("💣"),
          ),
        );
      } else {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorManager.border(context),
            ),
            color: ColorManager.itemClicked(context),
          ),
          child: Center(
            child: Text("${point.value}"),
          ),
        );
      }
    } else {
      if (state.status.value == GameStatus.running) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorManager.border(context),
            ),
            color: ColorManager.itemNotClicked(context),
          ),
          child: InkWell(
            onTap: () => state.tapItem(context, index),
          ),
        );
      } else {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorManager.border(context),
            ),
            color: ColorManager.itemNotClicked(context),
          ),
        );
      }
    }
  }

  Widget _gameResult(BuildContext context, HomeState state) {
    return Container(
      padding: EdgeInsets.all(10),
      color: ColorManager.surface(context),
      child: Center(
        child: Text(state.result.value),
      ),
    );
  }
}

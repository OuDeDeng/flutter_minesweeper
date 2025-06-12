import 'package:get/get.dart';

class AppEventBus extends GetxController {
  final duration = "".obs;
  void updateDuration(String value) {
    duration.value = value;
  }
}

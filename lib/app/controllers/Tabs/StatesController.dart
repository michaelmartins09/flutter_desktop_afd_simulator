import 'package:afd_system/app/models/models.dart';
import 'package:get/state_manager.dart';

class StatesController extends GetxController {
  var name = ''.obs;
  var label = ''.obs;

  var listStates = <State>[].obs;

  void sortList() => listStates.sort((a, b) => a.name.compareTo(b.name));
}

import 'package:afd_system/app/models/models.dart';
import 'package:get/state_manager.dart';

class TransitionsController extends GetxController {
  var listTransitions = <Transitions>[].obs;
  var origin = Rx<State>();
  var destiny = Rx<State>();
  var word = ''.obs;

  bool get transitionsSelecteds => word.value.isNotEmpty && origin?.value?.name != null && destiny?.value?.name != null;
}

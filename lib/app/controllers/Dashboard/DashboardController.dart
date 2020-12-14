import 'package:afd_system/app/models/models.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var currentPage = 0.obs;

  var states = RxList<State>();
  var finalState = RxList<State>();
  var transitions = RxList<Transitions>();
  var initState = Rx<State>();
  var alphabet = RxList<String>([]);

  checkStateFinalById(int id){
    for (var state in finalState) {
      if (state.id == id) return true;
    }
    return false;
  }

  bool get afdIsValid => states.length > 0 && finalState.length > 0 && initState?.value?.name != null && alphabet.length > 0 && transitions.length > 0;
}

import 'package:afd_system/app/models/models.dart';
import 'package:afd_system/app/utils/Enum/enum.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var currentPage = 0.obs;

  var states = RxList<State>();
  var finalState = RxList<State>();
  var transitions = RxList<Transitions>();
  var initState = Rx<State>();
  var alphabet = RxList<String>([]);

  var statusTest = TestAfd.none.obs;

  checkStateFinalById(int id){
    for (var state in finalState) {
      if (state.id == id) return true;
    }
    return false;
  }

  bool get afdIsValid => states.length > 0 && finalState.length > 0 && initState?.value?.name != null && alphabet.length > 0 && transitions.length > 0;

  Transitions getTransition({State origin, String word}){
    for (var transition in transitions) {
      if (transition.equalStart(origin) && transition.word == word) {
        return transition;
      }
    }
    return null;
  }

  State getState({int id}){
    for (var state in states) {
      if (state.id == id) {
        return state;
      }
    }
    return null;
  }

  bool startTestToInput({String input}){
    statusTest.value = TestAfd.loading;
    Future.delayed(Duration(milliseconds: 1800));
    State destiny;
    State origin = initState.value;
    Transitions transition;
    var letterNumber = 0;
    try {
      while (letterNumber < input.length) {
        if (input[1].isEmpty) {
          print('---ESTE AUTOMATO NÃO ACEITA PALAVRAS VAZIAS---');
          statusTest.value = TestAfd.notAccepted;
          break;
        }else{
          transition = getTransition(origin: origin, word: input[letterNumber]);
          destiny = transition.destiny;
          origin = destiny;
          print("Leu o símbolo \"${input[letterNumber]}\" foi para o "
            "\"${getState(id: origin.id).label}\"");
          letterNumber++;
        }
      }
    } on NoSuchMethodError {
      print("---alow =ESTE AUTOMATO NÃO ACEITA A PALAVRA $input---");
      statusTest.value = TestAfd.notAccepted;
      return false;
    } catch (ex) {
      statusTest.value = TestAfd.notAccepted;
      return false;
    }
    for (var finalState in finalState) {
      if (origin.id == finalState.id) {
        statusTest.value = TestAfd.accepted;
        print("---ESTE AUTOMATO CONSEGUIU LER A PALAVRA $input---");
        return true;
      }
    }
    statusTest.value = TestAfd.notAccepted;
    print("---ESTE AUTOMATO NÃO ACEITA A PALAVRA $input---");
    return false;
  }
}

import 'package:get/state_manager.dart';

class AlphabetsController extends GetxController {
  
  var chars = <String>[].obs;

  String get alphabets {
    String allAlphabets = chars.toString();
    String clearValue = allAlphabets.replaceAll('[', '').replaceAll(']', '');
    return clearValue;
  }

}

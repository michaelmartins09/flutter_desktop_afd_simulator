import 'package:afd_system/app/models/models.dart';

class Transitions {
  final State origin;
  final State destiny;
  final String word;

  Transitions({this.origin, this.destiny, this.word});

  bool equalStart(State state){
    return state.id == destiny.id;
  }

  bool equalFate(State state){
    return state.id == destiny.id;
  }

  bool equals(Transitions toCompare){
    if (toCompare.equalStart(origin)
      && toCompare.equalFate(origin) &&
      toCompare.word == word) {
        return true;
    }
    return false;
  }
  
}

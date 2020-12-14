import 'package:afd_system/app/controllers/Tabs/tabscontroller.dart';
import 'package:afd_system/app/controllers/controllers.dart';
import 'package:afd_system/app/models/models.dart';
import 'package:afd_system/view/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class TransitionsTab extends StatelessWidget {
  final TransitionsController controller;
  final StatesController statesController;
  final AlphabetsController alphabetsController;
  final DashboardController dashController;
  final TextEditingController textWordController = TextEditingController();

  TransitionsTab({Key key, this.controller, this.statesController, this.alphabetsController, @required this.dashController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => ButtonCircle(
                    title: controller.origin?.value?.name ?? 'Toque para\nselecionar\na origem', 
                    fontSize: controller.origin?.value?.name != null ? 22 : null,
                    onTap: () {
                      showDialog(
                        context: context,
                        useSafeArea: true,
                        barrierDismissible: true,
                        builder: (context) {
                          return Material(
                            color: Colors.transparent,
                            child: loadStates(context, isOrigin: true)
                          );
                        }
                      );
                    }
                  )),
                  SizedBox(width: 30),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: alphabetsController.chars.map((word) => Row(
                            children: [
                              Obx(() => ChoiceChip(
                                label: Text(word),
                                selected: controller.word.value == word,
                                onSelected: (bool) {
                                  controller.word.value = word;
                                  print(controller.word.value);
                                }
                              )),
                              SizedBox(width: 5)
                            ],
                          )).toList(),
                        ),
                        Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            Container(
                              width: 230,
                              height: 4,
                              margin: EdgeInsets.only(right: 14, top: 1),
                              color: Colors.white,
                            ),
                            Icon(FeatherIcons.chevronRight, size: 34)
                          ],
                        ),
                        Text('Selecione acima a palavra de transição')
                      ],
                    ),
                  ),
                  SizedBox(width: 30),
                  Obx(() => ButtonCircle(
                    title: controller.destiny?.value?.name ?? 'Toque para\nselecionar\no destino', 
                    fontSize: controller.destiny?.value?.name != null ? 22 : null,
                    onTap: () {
                      showDialog(
                        context: context,
                        useSafeArea: true,
                        barrierDismissible: true,
                        builder: (context) {
                          return Material(
                            color: Colors.transparent,
                            child: loadStates(context)
                          );
                        }
                      );
                    }
                  )),
                ],
              ),
              SizedBox(height: 30),
              Obx(() => Button(
                iconData: Icons.add,
                title: 'Adicionar',
                onTap: controller.transitionsSelecteds ? () {
                  Transitions transition = Transitions(
                    origin: controller.origin.value,
                    destiny: controller.destiny.value,
                    word: controller.word.value
                  );

                  bool containsThisTransition = false;

                  for (var item in controller.listTransitions) {
                    if (
                      item.origin.name == transition.origin.name &&
                      item.destiny.name == transition.destiny.name &&
                      item.word == transition.word
                    ){
                      containsThisTransition = true;
                    }
                  }

                  if (!containsThisTransition){
                    controller.listTransitions.add(transition);
                    dashController.transitions = controller.listTransitions;
                  }
                } : null,
              )),
              SizedBox(height: 30),
              Obx(() => Column(
                children: List.generate(
                  controller.listTransitions.length, (index) => Container(
                    color: Theme.of(context).backgroundColor,
                    margin: EdgeInsets.only(bottom: 4),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,  
                        child: Text(controller.listTransitions[index].origin.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Transita'),
                          SizedBox(width: 4),
                          Text(controller.listTransitions[index].word, style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22
                          )),
                          SizedBox(width: 4),
                          Text('para'),
                          Icon(FeatherIcons.chevronRight),
                          SizedBox(width: 10),
                          CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,  
                            child: Text(controller.listTransitions[index].destiny.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          )
                        ]
                      ),
                      trailing: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            controller.listTransitions.remove(controller.listTransitions[index]);
                            dashController.transitions = controller.listTransitions;
                          },
                          onTapCancel: () {
                            controller.listTransitions.remove(controller.listTransitions[index]);
                            dashController.transitions = controller.listTransitions;
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(FeatherIcons.trash),
                          ),
                        )
                      ),
                    ),
                  )
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget loadStates(BuildContext context, {bool isOrigin = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        statesController.listStates.length, (index) => Container(
          width: 250,
          color: Theme.of(context).backgroundColor,
          margin: EdgeInsets.only(bottom: 4),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,  
              child: Text(statesController.listStates[index].name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            title: Text(statesController.listStates[index].label),
            onTap: () {
              if (isOrigin){
                controller.origin.value = statesController.listStates[index];
                print("${controller.origin.value.name} selected origin!");
              } else {
                controller.destiny.value = statesController.listStates[index];
                print("${controller.destiny.value.name} selected destiny!");
              }
              Navigator.pop(context);
            },
          ),
        )
      ),
    );  
  }
}

import 'package:afd_system/app/controllers/Tabs/tabscontroller.dart';
import 'package:afd_system/app/controllers/controllers.dart';
import 'package:afd_system/app/models/models.dart' as models;
import 'package:afd_system/view/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class StatesTab extends StatelessWidget {
  final StatesController controller;
  final DashboardController dashController;
  final TextEditingController textNameController = TextEditingController();
  final TextEditingController textLabelController = TextEditingController();

  StatesTab({Key key, @required this.controller, @required this.dashController}) : super(key: key);

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
                  Center(
                    child: Column(
                      children: [
                        Obx(() => CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          minRadius: 50,  
                          child: Text(controller.name.value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        )),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Obx(() => Text(controller.label.value, style: TextStyle(color: Theme.of(context).backgroundColor))),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: TextFormField(
                      controller: textNameController,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        labelStyle: TextStyle(
                          fontSize: 22
                        )
                      ),
                      onChanged: controller.name
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: TextFormField(
                      controller: textLabelController,
                      decoration: InputDecoration(
                        labelText: 'Label',
                        labelStyle: TextStyle(
                          fontSize: 22
                        )
                      ),
                      onChanged: controller.label,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Obx(() => Button(
                iconData: Icons.add,
                title: 'Adicionar',
                onTap: controller.name.value.isEmpty ? null : () {
                  models.State state = models.State(
                    name: controller.name.value,
                    label: controller.label.value,
                    id: controller.listStates.length
                  );

                  bool containsState = false;

                  for (var item in controller.listStates) {
                    if (item.name == controller.name.value){
                      containsState = true;
                    }
                  }

                  if (!containsState){
                    controller.listStates.add(state);
                    controller.sortList();
                    dashController.states = controller.listStates;
                    print(dashController.states);
                  }
                },
              )),
              SizedBox(height: 30),
              Obx(() => Column(
                children: List.generate(
                  controller.listStates.length, (index) => Container(
                    color: Theme.of(context).backgroundColor,
                    margin: EdgeInsets.only(bottom: 4),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,  
                        child: Text(controller.listStates[index].name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      title: Text(controller.listStates[index].label),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() => ChoiceChip(
                            label: Text('Inicial'),
                            selected: dashController?.initState?.value?.name == controller.listStates[index].name,
                            labelStyle: TextStyle(color: Colors.white),
                            disabledColor: Theme.of(context).backgroundColor.withOpacity(0.1),
                            onSelected: (bool) => dashController?.initState?.value?.name == controller.listStates[index].name ? dashController.initState = Rx<models.State>() : dashController.initState.value = controller.listStates[index],
                          )),
                          SizedBox(width: 10),
                          Obx(() => ChoiceChip(
                            label: Text('Final'),
                            selected: dashController.checkStateFinalById(controller.listStates[index].id),
                            labelStyle: TextStyle(color: Colors.white),
                            onSelected: (bool) => dashController.checkStateFinalById(controller.listStates[index].id) ? dashController.finalState.remove(controller.listStates[index]) : dashController.finalState.add(controller.listStates[index]) ,
                            disabledColor: Theme.of(context).backgroundColor.withOpacity(0.1),
                          )),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                controller.listStates.removeAt(index);
                                controller.sortList();
                                dashController.states = controller.listStates;
                              }, 
                              onTapCancel:  () {
                                controller.listStates.removeAt(index);
                                controller.sortList();
                                dashController.states = controller.listStates;
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Icon(FeatherIcons.trash),
                              ),
                            )
                          ),
                        ],
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
}

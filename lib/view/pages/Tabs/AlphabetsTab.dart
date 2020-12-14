import 'package:afd_system/app/controllers/Tabs/tabscontroller.dart';
import 'package:afd_system/app/controllers/controllers.dart';
import 'package:afd_system/view/components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlphabetsTab extends StatelessWidget {
  final DashboardController dashController;
  final AlphabetsController controller;
  final TextEditingController textEditingController = TextEditingController();

  AlphabetsTab({Key key, @required this.controller, @required this.dashController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: 'Alfabeto',
                labelStyle: TextStyle(
                  fontSize: 22
                )
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Button(
                  iconData: Icons.add,
                  title: 'Adicionar',
                  onTap: () {
                    if (textEditingController.text.isNotEmpty){
                      if (textEditingController.text == ' ') {
                        if (!controller.chars.contains('Ø')){
                          controller.chars.add('Ø');
                          dashController.alphabet = controller.chars;
                        }
                      } else {
                        if (!controller.chars.contains(textEditingController.text)) {
                          controller.chars.add(textEditingController.text);
                          dashController.alphabet = controller.chars;
                        }
                      }
                      dashController.alphabet = controller.chars;
                      print(controller.chars);
                    }
                  },
                ),
                SizedBox(width: 20),
                Button(
                  color: Theme.of(context).backgroundColor,
                  colorTitle: Colors.white,
                  iconData: Icons.clear,
                  title: 'Limpar',
                  onTap: () {
                    controller.chars.clear();
                    dashController.alphabet = controller.chars;

                    print(controller.chars);
                  },
                ),
                SizedBox(width: 20),
                Button(
                  color: Theme.of(context).backgroundColor,
                  colorTitle: Colors.white,
                  iconData: Icons.clear,
                  title: 'Remover último',
                  onTap: () {
                    if (controller.chars.length > 0){
                      controller.chars.removeLast();
                      print(controller.chars);
                      dashController.alphabet = controller.chars;
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 50),
            Obx(() => Text("Σ = { ${controller.alphabets} }", style: TextStyle(
              fontSize: 48
            ), textAlign: TextAlign.center))
          ],
        ),
      ),
    );
  }
}

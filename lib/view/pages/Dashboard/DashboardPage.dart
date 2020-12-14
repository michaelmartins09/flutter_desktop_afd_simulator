import 'package:afd_system/app/controllers/Tabs/tabscontroller.dart';
import 'package:afd_system/app/controllers/controllers.dart';
import 'package:afd_system/view/components/components.dart';
import 'package:afd_system/view/pages/Tabs/tabs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DashboardController controller = DashboardController();

  AlphabetsController alphabetsController = AlphabetsController();
  StatesController statesController = StatesController();
  TransitionsController transitionsController = TransitionsController();

  List<String> listButtonsName = [
    "Alfabetos",
    "Estados",
    "Transições",
  ];

  List<Widget> listTabs;

  @override
  void initState() { 
    listTabs = [
      AlphabetsTab(controller: alphabetsController, dashController: controller),
      StatesTab(controller: statesController, dashController: controller),
      TransitionsTab(
        controller: transitionsController,
        statesController: statesController,
        alphabetsController: alphabetsController,
        dashController: controller
      ),
      TestTab(dashController: controller)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width * 0.35,
            color: Theme.of(context).backgroundColor,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 40),
                Text(
                  'Autômato\nFinito Determinístico',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 40),
                Column(
                  children: List.generate(
                    listButtonsName.length, (index) => Obx(() => HeadlineButton(
                      title: listButtonsName[index], 
                      number: index + 1,
                      onTap: () => controller.currentPage.value = index,
                      current: index == controller.currentPage.value,
                      isCompleted: checkCompletedByTab(index),
                    ))
                  )
                ),
                SizedBox(height: 40),
                Button(
                  iconData: Icons.play_arrow,
                  title: "Testar palavra",
                  onTap: () => controller.currentPage.value = 3,
                ),
                SizedBox(height: 40),
                Text("Criado por Matheus Kildere e Michael Martins", style: TextStyle(
                  color: Theme.of(context).primaryColor.withOpacity(0.4)
                ))
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.all(20),
              child: Obx(() => listTabs[controller.currentPage.value])
            ),
          )
        ],
      ),
    );
  }

  checkCompletedByTab(int index) {
    switch (index) {
      case 0:
        return alphabetsController.chars.length >= 1;
        break;
      case 1:
        return statesController.listStates.length >= 1;
        break;
      case 2:
        return transitionsController.listTransitions.length >= 1;
        break;
      default:
      return false;
    }
  }
}

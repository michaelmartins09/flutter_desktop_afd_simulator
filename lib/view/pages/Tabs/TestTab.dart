import 'package:afd_system/app/controllers/controllers.dart';
import 'package:afd_system/app/utils/Enum/enum.dart';
import 'package:afd_system/view/components/button/Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class TestTab extends StatelessWidget {
  final DashboardController dashController;

  final TextEditingController textEditingController = TextEditingController();

  TestTab({Key key, this.dashController}) : super(key: key);

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
                labelText: 'Palavra',
                labelStyle: TextStyle(
                  fontSize: 22
                ),
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Button(
                  iconData: Icons.play_arrow,
                  title: 'Executar',
                  onTap: () => dashController.startTestToInput(input: textEditingController.text),
                ),
              ],
            ),
            SizedBox(height: 50),
            Obx(() {
              if (dashController.statusTest.value == TestAfd.loading){
                return CircularProgressIndicator();
              }
              if (dashController.statusTest.value == TestAfd.notAccepted){
                return Text("Palavra NÃO aceita", style: TextStyle(
                    fontSize: 48, color: Colors.red[300]
                  ), textAlign: TextAlign.center
                );
              }
              if (dashController.statusTest.value == TestAfd.accepted){
                return Text("Palavra ACEITA", style: TextStyle(
                    fontSize: 48, color: Theme.of(context).primaryColor
                  ), textAlign: TextAlign.center
                );
              }
              return Text("Aguardando palavra para teste ...", style: TextStyle(
                  fontSize: 48
                ), textAlign: TextAlign.center
              );
            })
          ],
        ),
      ),
    );
  }
}

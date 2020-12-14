import 'package:afd_system/app/controllers/controllers.dart';
import 'package:afd_system/view/components/button/Button.dart';
import 'package:flutter/material.dart';
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
                  title: 'Executar',
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 50),
            Text("Resultado = Aceita estático", style: TextStyle(
              fontSize: 48
            ), textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}

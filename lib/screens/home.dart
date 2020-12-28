import 'package:assignment_2_yts_api/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        appBar: AppBar(
          title: Text("Latest Movies"),
          centerTitle: true,
          bottomOpacity: 0.0,
          backgroundColor: Colors.indigoAccent,
        ),
        body: GetBuilder(
            init: Controller(),
            builder: (Controller controller) => RefreshIndicator(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: controller.cards,
                ),
                onRefresh: () async {
                  return await controller.init();
                })));
  }
}

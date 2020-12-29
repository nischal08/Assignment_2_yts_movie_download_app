import 'package:assignment_2_yts_api/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  double _height;
  double _width;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/background.jpg"),
        fit: BoxFit.fitHeight,
        colorFilter: ColorFilter.mode(Colors.blueGrey, BlendMode.hardLight),
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent.withOpacity(.5),
        appBar: AppBar(
          leading: Icon(
            Icons.person,
            size: 30,
          ),
          title: Text(
            "Latest Movies",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.blueGrey.withOpacity(0),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: Icon(
                Icons.search_sharp,
                size: 30,
              ),
            )
          ],
        ),
        body: GetBuilder(
          init: Controller(),
          builder: (Controller controller) => RefreshIndicator(
            child: controller.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          (MediaQuery.of(context).size.width * .15).toDouble(),
                      vertical:
                          (MediaQuery.of(context).size.width * .05).toDouble(),
                    ),
                    children: controller.cards,
                  ),
            onRefresh: () async {
              return await controller.init();
            },
          ),
        ),
      ),
    );
  }
}

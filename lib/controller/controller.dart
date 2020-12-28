import 'dart:convert';

import 'package:assignment_2_yts_api/model/moviesModel.dart';
import 'package:assignment_2_yts_api/screens/customCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Controller extends GetxController {
  var count = 1;
  List<Widget> _cards = [SizedBox()];

  List<Widget> get cards => _cards;

  set cards(List value) {
    _cards = value;
  }

  Controller() {
    init();
  }

  Future<void> init() async {
    _cards = [
      Center(
        child: CircularProgressIndicator(),
      )
    ];
    update();
    await _loadCards();
    update();
  }

  List<Widget> tempList = List();
  Future _loadCards() async {
    List<MoviesModel> modelList =
        await getData("https://yts.mx/api/v2/list_movies.json?page=$count");
    for (var i = 0; i < modelList.length; i++) {
      MoviesModel model = MoviesModel(
          movieRealeaseYear: modelList[i].movieRealeaseYear,
          movieImgUrl: modelList[i].movieImgUrl,
          movieName: modelList[i].movieName,
          rating: modelList[i].rating);
      tempList.add(CustomCard(model));
    }
    _cards = tempList;
  }

  static Future<List<MoviesModel>> getData(url) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      print("ok");
    }
    dynamic decodedResponse = jsonDecode(response.body);
    List<MoviesModel> decodedResponseModelList = List();
    // print(decodedResponse);
    for (var each in decodedResponse["data"]["movies"]) {
      MoviesModel model = MoviesModel(
        movieName: each["title"],
        movieImgUrl: each["medium_cover_image"],
        movieRealeaseYear: each["year"],
        rating: each["rating"],
      );
      decodedResponseModelList.add(model);
    }
    return decodedResponseModelList;
  }
}

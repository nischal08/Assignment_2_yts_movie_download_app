import 'dart:convert';

import 'package:assignment_2_yts_api/model/movieDetailModel.dart';
import 'package:assignment_2_yts_api/model/moviesModel.dart';
import 'package:assignment_2_yts_api/screens/customCard.dart';
import 'package:assignment_2_yts_api/screens/customDetailCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Controller extends GetxController {
  var id;

  var count = 1;
  bool isLoading;
  List<Widget> _cards = [SizedBox()];

  List<Widget> get cards => _cards;

  set cards(List value) {
    _cards = value;
  }

  Controller() {
    init();
  }

  Future<void> init() async {
    _cards.clear();
    isLoading = true;
    update();

    await _loadCards();
    isLoading = false;
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
        rating: modelList[i].rating,
      );
      tempList.add(GestureDetector(
        child: CustomCard(model),
        onTap: () async {
          await _loadDetailCard(id: modelList[i].id);
        },
      ));
    }
    tempList.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        customIconButton(
            iconData: Icons.arrow_back_ios,
            onPress: () {
              _prevPage();
            }),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            count.toString(),
            style: TextStyle(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        customIconButton(
            iconData: Icons.arrow_forward_ios,
            onPress: () {
              _nextPage();
            }),
      ],
    ));
    _cards = tempList;
  }

  void _prevPage() {
    if (count > 1) {
      _cards.clear();
      count--;
      update();
      init();
    }
  }

  void _nextPage() {
    _cards.clear();
    count++;
    update();
    init();
  }

  Widget customIconButton({
    @required IconData iconData,
    @required Function onPress,
  }) {
    return IconButton(
      focusColor: Colors.green,
      icon: Icon(
        iconData,
        size: 30,
        color: Colors.white,
      ),
      onPressed: onPress,
    );
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
        id: each["id"],
      );
      decodedResponseModelList.add(model);
    }
    return decodedResponseModelList;
  }

  static Future<MovieDetailModel> getMovieDetail(url) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      print("ok");
    }
    dynamic decodedResponse = jsonDecode(response.body);

    // print(decodedResponse);
    dynamic decodedResponseReady = decodedResponse["data"]["movie"];
    print(decodedResponseReady["torrents"]);
    MovieDetailModel detailModel = MovieDetailModel(
        title: decodedResponseReady["title"],
        realeaseYear: decodedResponseReady["year"],
        genres: decodedResponseReady["genres"],
        movieDesc: decodedResponseReady["description_full"],
        rating: decodedResponseReady["rating"],
        torrent: decodedResponseReady["torrents"],
        image: decodedResponseReady["large_cover_image"],
        runtime: decodedResponseReady["runtime"],
        downloadCount: decodedResponseReady["download_count"]);

    return detailModel;
  }

  Future _loadDetailCard({id}) async {
    dynamic model = await getMovieDetail(
        "https://yts.mx/api/v2/movie_details.json?movie_id=$id");

    MovieDetailModel modelList = MovieDetailModel(
        title: model.title,
        rating: model.rating,
        genres: model.genres,
        movieDesc: model.movieDesc,
        realeaseYear: model.realeaseYear,
        torrent: model.torrent,
        image: model.image,
        runtime: model.runtime,
        downloadCount: model.downloadCount);
    return Get.to(CustomDetailCard(
      detailModel: modelList,
    ));
  }
}

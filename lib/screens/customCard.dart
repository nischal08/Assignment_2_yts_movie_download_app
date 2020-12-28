import 'package:assignment_2_yts_api/model/moviesModel.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final MoviesModel model;
  CustomCard(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      model.movieImgUrl,
                      scale: 0.8,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  model.movieName,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  model.movieRealeaseYear.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/imdb.png",
                      scale: 1.2,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      model.rating.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

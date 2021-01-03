import 'dart:ui';

import 'package:assignment_2_yts_api/model/movieDetailModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDetailCard extends StatelessWidget {
  double _height;
  double _width;
  MovieDetailModel detailModel;
  CustomDetailCard({this.detailModel});
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return _main(context);
  }

  Widget _main(context) {
    return Container(
      height: _height * .7,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: detailModel.image == null
                  ? AssetImage("assets/background.jpg")
                  : NetworkImage(
                      detailModel.image,
                    ),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent.withOpacity(0.6),
        appBar: _appBar(context),
        body: _body(context),
      ),
    );
  }

  Widget _body(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _title(),
        _customEightSizedBox(height: 5),
        _infoContainer(context),
      ],
    );
  }

  Widget _infoContainer(context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff1D1D27),
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(20),
        //   topRight: Radius.circular(20),
        // ),
      ),
      height: MediaQuery.of(context).size.height * .5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _customEightSizedBox(),
              _genre(),
              _customDivider(),
              _customEightSizedBox(),
              _rateCount(),
              _customEightSizedBox(),
              _customDivider(),
              _customEightSizedBox(),
              _synopsis(),
              _customEightSizedBox(),
              _customDivider(),
              _customEightSizedBox(),
              _downloadFile(),
              _customEightSizedBox(width: 5),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customEightSizedBox({double height, double width}) {
    return SizedBox(
      height: height ?? 8,
      width: width ?? 0,
    );
  }

  Widget _downloadFile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _downloadLabel(),
        _customEightSizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _downloadLink(),
            _downloadSize(),
          ],
        ),
      ],
    );
  }

  Widget _downloadSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ...detailModel.torrent.map(
          (e) => Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    e["size"],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Icon(
                  Icons.folder_rounded,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _downloadLink() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...detailModel.torrent.map(
          (e) => GestureDetector(
            onTap: () => launch(e["url"]),
            child: Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Card(
                elevation: 0.1,
                color: Colors.grey.withOpacity(0.3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        e["quality"],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Icon(
                      Icons.file_download,
                      color: Colors.green,
                      size: 30,
                    ),
                    _customEightSizedBox()
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _downloadLabel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Torrent Download",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
        Text(
          "File Size",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _synopsis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Synopsis",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          detailModel.movieDesc,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 16,
          ),
        )
      ],
    );
  }

  Widget _appBar(context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios_rounded,
          size: 20,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Text(
        detailModel.title,
        style: TextStyle(
            fontSize: 30, color: Colors.white, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _rateCount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _numberWithText(
            label: "Release Year", value: detailModel.realeaseYear.toString()),
        _iconWithText("${detailModel.rating.toString()} /10"),
        _numberWithText(
            label: "Runtime", value: "${detailModel.runtime.toString()} mins"),
      ],
    );
  }

  Widget _numberWithText({String value, String label}) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, color: Colors.green),
        ),
        _customEightSizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 17, color: Colors.white),
        )
      ],
    );
  }

  Widget _iconWithText(String text) {
    return Column(
      children: [
        Icon(
          Icons.star_rate_rounded,
          color: Colors.redAccent,
        ),
        _customEightSizedBox(height: 5),
        Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 17, color: Colors.white),
        )
      ],
    );
  }

  Widget _customDivider() {
    return Divider(
      color: Colors.grey.shade600,
      height: 20,
    );
  }

  Widget _genre() {
    return SizedBox(
      width: _width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...detailModel.genres.map((e) => Card(
                elevation: 0.1,
                color: Colors.grey.withOpacity(0.2),
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text(
                    e,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )))
          ],
        ),
      ),
    );
  }
}

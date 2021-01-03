import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:assignment_2_yts_api/components/roundedButton.dart';
import 'package:assignment_2_yts_api/screens/loginScreen.dart';
import 'package:assignment_2_yts_api/screens/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animationController.forward();
    animation.addListener(() {
      setState(() {});
      print(animationController.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Hero(
                tag: 'logo',
                child: Icon(
                  Icons.movie_filter_outlined,
                  size: animation.value * 70,
                  color: Colors.indigoAccent,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              TypewriterAnimatedTextKit(
                text: ["Torvie Movies", "Download", "HD Movies", "For Free"],
                speed: Duration(milliseconds: 100),
                textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 40.0),
              ),
            ],
          ),
          SizedBox(
            height: 60.0,
          ),
          RoundedButton(
            color: Colors.lightBlueAccent,
            title: "Log In",
            onPressed: () {
              Get.to(LoginScreen());
            },
          ),
          RoundedButton(
            color: Colors.blueAccent,
            title: "Register Now",
            onPressed: () {
              Get.to(RegisterScreen());
            },
          ),
        ],
      ),
    );
  }
}

import 'package:assignment_2_yts_api/components/roundedButton.dart';
import 'package:assignment_2_yts_api/constants.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
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
          Hero(
            tag: 'logo',
            child: Icon(
              Icons.movie_filter_outlined,
              size: 200.0,
              color: Colors.indigoAccent,
            ),
          ),
          SizedBox(
            height: 48.0,
          ),
          TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.emailAddress,
            decoration:
                kTextFieldDecoration.copyWith(hintText: "Enter your email"),
          ),
          SizedBox(
            height: 8.0,
          ),
          TextField(
            obscureText: true,
            textAlign: TextAlign.center,
            decoration:
                kTextFieldDecoration.copyWith(hintText: "Enter your password"),
          ),
          SizedBox(
            height: 24.0,
          ),
          RoundedButton(
            color: Colors.blueAccent,
            title: "Register",
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

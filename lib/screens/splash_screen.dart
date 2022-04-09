// import 'dart:html';

import 'package:splash_screen_view/SplashScreenView.dart';

import 'package:flutter/material.dart';

import 'p_dchecker.dart';

class MySplashScreen extends StatelessWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.end,

        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.025),
              child: Text(
                'WELCOME',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: size.height * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Hero(
              tag: 'login',
              child: SplashScreenView(
                navigateRoute: const PDChecker(),
                duration: 4800,
                imageSize: 230,
                imageSrc: 'assets/images/logo.png',
                text: "Autism Detection",
                textType: TextType.ColorizeAnimationText,
                textStyle: TextStyle(
                  fontSize: size.width * 0.08,
                  fontWeight: FontWeight.bold,
                ),
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).hintColor,
                  Theme.of(context).primaryColor,
                  Theme.of(context).hintColor,
                  Theme.of(context).hintColor,
                  Theme.of(context).primaryColor,
                ],
                backgroundColor: Theme.of(context).backgroundColor,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size.height * 0.01),
            child: Text(
              'Developed by ODIWS',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: size.width * 0.04),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:firebase_sample/screens/product_list.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ProductListScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset("lib/assets/fruitshop.jpg")),
    );
  }
}

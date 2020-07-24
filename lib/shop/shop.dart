import 'package:flutter/material.dart';
import 'package:rescuefy/shop/body.dart';
import 'package:rescuefy/shop/constants.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class shop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  GradientAppBar buildAppBar() {
    return GradientAppBar(
      gradient: LinearGradient(colors: [Colors.indigo, Colors.cyan]),
      elevation: 0.0,
      title: Text('Rescuefy'),
      actions: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.home),
          label: Text('Home'),
        ),
      ],
    );
  }
}

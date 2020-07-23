import 'package:flutter/material.dart';
import 'package:rescuefy/screens/home/config/palette.dart';
import 'package:rescuefy/services/auth.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final AuthService _auth = AuthService();
  final String locality;

  CustomAppBar({Key key, @required this.locality}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.primaryColor,
      elevation: 0.0,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        iconSize: 28.0,
        onPressed: () {},
      ),
      title: Text(locality),
      actions: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.person),
          label: Text(
            'logout',
            style: TextStyle(fontSize: 20.0),
          ),
          onPressed: () async {
            await _auth.signOut();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

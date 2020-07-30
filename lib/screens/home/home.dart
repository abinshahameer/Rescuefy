import 'package:flutter/material.dart';

//import 'package:gradient_app_bar/gradient_app_bar.dart';
//import 'package:rescuefy/services/auth.dart';
import 'package:rescuefy/screens/home/config/palette.dart';
import 'package:rescuefy/screens/home/config/styles.dart';
import 'package:rescuefy/screens/home/config/custom_app_bar.dart';

//import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rescuefy/screens/home/config/data.dart';
import 'package:rescuefy/shop/shop.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:rescuefy/shop/body.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //final AuthService _auth = AuthService();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;
  String _locality = "";
  final List _screens = [
    Home(),
    //StatsScreen(),
    Scaffold(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    Future<void> location() async {
      await _getCurrentLocation();
    }

    location();

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(locality: _locality),
        body: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            _buildHeader(screenHeight),
            _buildPreventionTips(screenHeight),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 55,
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            elevation: 0.0,
            items: [Icons.home, Icons.info]
                .asMap()
                .map((key, value) => MapEntry(
                      key,
                      BottomNavigationBarItem(
                        title: Text(''),
                        icon: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 16.0,
                          ),
                          decoration: BoxDecoration(
                            color: _currentIndex == key
                                ? Colors.indigo
                                : Colors.cyan,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Icon(
                            value,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ))
                .values
                .toList(),
          ),
        ),
      ),

    );
  }

  SliverToBoxAdapter _buildHeader(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Palette.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Rescuefy',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Are you in Emergency?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'If you have any Emergency, please alert us or text us immediately. Our nearest volunteer will reach you shortly.',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton.icon(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      onPressed: () {},
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      icon: const Icon(
                        Icons.add_alert,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Alert Now',
                        style: Styles.buttonTextStyle,
                      ),
                      textColor: Colors.white,
                    ),
                    FlatButton.icon(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      onPressed: () {},
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      icon: const Icon(
                        Icons.chat_bubble,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Send SMS',
                        style: Styles.buttonTextStyle,
                      ),
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildPreventionTips(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
            Text(
              'Food',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: food
                  .map((e) =>
                  GestureDetector(
                    onTap: () {
                      if (e.values.first == 'Order\nFood') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => shop()),
                        );
                      } else if (e.values.first == 'Register\nRestaurants')
                    },
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          e.keys.first,
                          height: screenHeight * 0.12,
                          width: screenHeight * 0.12,
                        ),
                        SizedBox(height: screenHeight * 0.015),
                            Text(
                              e.values.first,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ))
                  .toList(),
            ),

            Text(
              'Medical',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: medical
                  .map((e) => Column(
                        children: <Widget>[
                          Image.asset(
                            e.keys.first,
                            height: screenHeight * 0.12,
                            width: screenHeight * 0.12,
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Text(
                            e.values.first,
                            style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ))
                  .toList(),
            ),
            Text(
              'Support',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: support
                  .map((e) =>
                  Column(
                    children: <Widget>[
                      Image.asset(
                        e.keys.first,
                        height: screenHeight * 0.12,
                        width: screenHeight * 0.12,
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Text(
                        e.values.first,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ))
                  .toList(),
            ),

            Text(
              'Register Complaints',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: complaints
                  .map((e) =>
                  Column(
                    children: <Widget>[
                      Image.asset(
                        e.keys.first,
                        height: screenHeight * 0.12,
                        width: screenHeight * 0.12,
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Text(
                        e.values.first,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ))
                  .toList(),
            ),
            Text(
              'Other Services',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: services
                  .map((e) =>
                  Column(
                    children: <Widget>[
                      Image.asset(
                        e.keys.first,
                        height: screenHeight * 0.12,
                        width: screenHeight * 0.12,

//                        height: screenHeight * 0.12,
//                        width: screenHeight*0.01,

                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Text(
                        e.values.first,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ))
                  .toList(),
            ),

            const SizedBox(height: 30),
            RaisedButton(
              onPressed: () {},
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                width: 500,
                height: 60,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Colors.blue,
                      Colors.red,
                      //Color(0xFF42A5F5),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child:
                Center(child: const Text('REQUEST EMERGENCY RESCUE',
                    style: TextStyle(fontSize: 20))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() async {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
        _locality = place.locality;
      });
    } catch (e) {
      print(e);
    }
  }

//  _launchURL() async {
//    const url = 'https://flutter.dev';
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
//  }

}

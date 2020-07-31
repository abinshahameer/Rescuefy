import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rescuefy/shared/loading.dart';

class NearbyVolunteers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: GradientAppBar(
          gradient: LinearGradient(colors: [Colors.indigo, Colors.cyan]),
          elevation: 0.0,
          title: Text('Rescuefy'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.home),
              label: Text('Home'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: VolunteerList(),
      ),
    );
  }
}

class VolunteerList extends StatefulWidget {
  @override
  _VolunteerListState createState() => _VolunteerListState();
}

class _VolunteerListState extends State<VolunteerList> {
  Future getList() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("Volunteers").getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getList(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].data["name"]),
                      subtitle: Text(snapshot.data[index].data["phone"]),
                    );
                  });
            }
          }),
    );
  }
}

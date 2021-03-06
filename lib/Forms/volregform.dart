import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VolunteerRegister extends StatelessWidget {
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
        body: FormVolReg(),
      ),
    );
  }
}

class FormVolReg extends StatefulWidget {
  @override
  _FormVolRegState createState() => _FormVolRegState();
}

class _FormVolRegState extends State<FormVolReg> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String phone = "";
  String job = "";
  final firestoreInstance = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
//          TextFormField(
//            validator: (value) {
//              if (value.isEmpty) {
//                return 'Please enter some text';
//              }
//              return null;
//            },
//          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Enter your name',
              labelText: 'Name',
            ),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.phone),
              hintText: 'Enter a phone number',
              labelText: 'Phone',
            ),
            onChanged: (val) {
              setState(() {
                phone = val;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.location_city),
              hintText: 'Enter you location',
              labelText: 'location',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.menu),
              hintText: 'Enter you Job',
              labelText: 'Job',
            ),
            onChanged: (val) {
              setState(() {
                job = val;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  firestoreInstance
                      .collection("Volunteers")
                      .document(name)
                      .setData({
                    "name": name,
                    "phone": phone,
                    "job": job,
                  }).then((_) {
                    print("success");
                  });
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

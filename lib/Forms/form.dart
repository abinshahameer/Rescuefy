import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class RestaurantRegister extends StatelessWidget {
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
              onPressed: null,
            ),
          ],
        ),
        body: FormResReg(),
      ),
    );
  }
}

class FormResReg extends StatefulWidget {
  @override
  _FormResRegState createState() => _FormResRegState();
}

class _FormResRegState extends State<FormResReg> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
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
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
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

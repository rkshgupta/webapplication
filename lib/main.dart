// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'fileUploader.dart';
import 'httpRequest.dart';
// import 'uploader.dart';

void main() => runApp(MaterialApp(initialRoute: '/home', routes: {
      '/': (context) => MyApp(),
      '/home': (context) => FileUploadTester(),
      // '/upload': (context) => Settings(),
    }));

String name = "";
String email = "";
String gender = "";
String superUser = "";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String data = "Get Your Data Here...";
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      autovalidate: true,
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration:
                InputDecoration(hintText: 'Enter Name', labelText: 'Name'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
          ),
          TextFormField(
            decoration:
                InputDecoration(hintText: 'Enter Email', labelText: 'Email'),
            validator: (value) {
              if (!RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                  .hasMatch(value)) {
                return 'Please valid email';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
          ),
          DropdownButtonFormField(
            decoration:
                InputDecoration(hintText: 'Select gender', labelText: 'Gender'),
            validator: (value) {
              if (value == null) {
                return 'Please select a gender';
              }
              return null;
            },
            items: ["Male", "Female"]
                .map((label) => DropdownMenuItem(
                      child: Text(label),
                      value: label,
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  gender = value;
                }
              });
            },
          ),
          Row(
            children: [
              Text("Super User"),
              Radio(
                  value: "Yes",
                  groupValue: superUser,
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        superUser = value;
                      }
                    });
                  }),
              Text("Yes"),
              Radio(
                  value: "No",
                  groupValue: superUser,
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        superUser = value;
                      }
                    });
                  }),
              Text("No")
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: RaisedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  Navigator.pushNamed(context, '/home');
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Name: $name'),
              SizedBox(
                width: 20.0,
              ),
              Text('Email: $email'),
              SizedBox(
                width: 20.0,
              ),
              Text('Gender: $gender'),
              SizedBox(
                width: 20.0,
              ),
              Text('SuperUser: $superUser'),
            ],
            crossAxisAlignment: CrossAxisAlignment.end,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                  onPressed: () {
                    getUrldata(1);
                  },
                  child: Text("Get Job Data")),
              RaisedButton(
                  onPressed: () {
                    getUrldata(2);
                  },
                  child: Text("Apply Job Data")),
              RaisedButton(
                  onPressed: () {
                    getUrldata(3);
                  },
                  child: Text("Post Data")),
              RaisedButton(
                  onPressed: () {
                    getUrldata(4);
                  },
                  child: Text("News Data")),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Text(data)),
              ],
            ),
          ),
          // _startFilePicker(),
        ],
      ),
    );
  }

  String option1Text = "Initialized text option1";
  Uint8List uploadedImage;
  FileUploadInputElement element = FileUploadInputElement()..id = "file_input";
  // setup File Reader
  FileReader fileReader = FileReader();

  getUrldata(func) async {
    HttpReq req = new HttpReq();
    if (func == 1) {
      await req.getRedditData();
    } else if (func == 2) {
      await req.applyApplicant("asfsafas@sfasf.com");
    } else if (func == 3) {
      await req.postData();
    } else if (func == 4) {
      await req.newsData();
    }
    setState(() {
      data = req.data;
    });
  }
}

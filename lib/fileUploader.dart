import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:html';

class FileUploadTester extends StatefulWidget {
  @override
  _FileUploadTesterState createState() => _FileUploadTesterState();
}

class _FileUploadTesterState extends State<FileUploadTester> {
  String option1Text = "Initialized text option1";
  Uint8List uploadedImage;
  FileUploadInputElement element = FileUploadInputElement()..id = "file_input";
  // setup File Reader
  FileReader fileReader = FileReader();

  // reader.onerror = (evt) => print("error ${reader.error.code}");
  @override
  Widget build(BuildContext context) {
    ui.platformViewRegistry.registerViewFactory("add_input", (int viewId) {
      return element;
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(child: HtmlElementView(viewType: 'add_input')),
        FlatButton(
          child: Text('Show Image'),
          color: Colors.tealAccent,
          onPressed: () {
            fileReader.onLoad.listen((data) {
              setState(() {
                uploadedImage = fileReader.result;
              });
            });
            fileReader.onError.listen((fileEvent) {
              setState(() {
                option1Text = "Some Error occured while reading the file";
              });
            });
            fileReader.readAsArrayBuffer(element.files[0]);
          },
        ),
      ],
    );
  }
}

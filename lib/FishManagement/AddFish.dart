import 'dart:html';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddFish extends StatefulWidget {
  @override
  State<AddFish> createState() => _AddFishState();
}

class _AddFishState extends State<AddFish> {
  TextEditingController fishnameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  late File _image;

  // const AddFish({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Fish Details",
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Text(
            "Add Fish Details Form",
            style: TextStyle(fontSize: 30.0),
          ),
          Form(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: fishnameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Fish Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                    prefixIcon: Icon(Icons.description),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price',
                    prefixIcon: Icon(Icons.price_change),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price',
                    prefixIcon: Icon(Icons.price_change),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter the title";
                    }
                    return null;
                  },
                ),
              ),
              CircleAvatar(
                radius: 20,
                // backgroundImage: FileImage(_image),
              ),
              RaisedButton(
                onPressed: () {
                  SelectImage();
                },
                child: Text("Select Image"),
              ),
              FlatButton(
                onPressed: () => {},
                child: Text("Submit"),
                color: Colors.blueAccent,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
              )
            ],
          )),
        ],
      ),
    );
  }
}

void SelectImage() async {
  ImagePicker imagePicker = new ImagePicker();
  var image = await imagePicker.pickImage(source: ImageSource.gallery);
  // setState(() {
  //   image = image;
  // });
}

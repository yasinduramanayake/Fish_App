import 'dart:html';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert' show jsonEncode;
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class AddFish extends StatefulWidget {
  @override
  State<AddFish> createState() => _AddFishState();
}

class _AddFishState extends State<AddFish> {
  TextEditingController fishnameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();

  String name = '';
  String description = '';
  double price = 0.0;
  late File _image;
  String Api_Url = 'http://localhost:8000/api/register';

  GlobalToast(massage, Color color1) {
    return Fluttertoast.showToast(
        msg: massage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  createUser() async {
    Object fish = {
      'name': name,
      'description': description,
      'price': price,
      'image': _image,
    };
    String Final_fish = jsonEncode(fish);

    final Uri url = Uri.parse(Api_Url);
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'supportsCredentials': 'true',
          'allowedOrigins': '*',
          'allowedOriginsPatterns': '',
          'allowedHeaders': '*',
          'allowedMethods': '*',
        },
        body: Final_fish);

    // Dispatch action depending upon
    // the server response
    if (response.statusCode == 200) {
      GlobalToast('Successful Added', Colors.green);
    } else if (response.statusCode == 422) {
      GlobalToast('Given data is invalid', Colors.red);
    } else if (response.statusCode == 500) {
      GlobalToast('Internal server error', Colors.orange);
    } else if (response.statusCode == 400) {
      GlobalToast('Bad request', Colors.yellow);
    } else if (response.statusCode == 404) {
      GlobalToast('404 not found', Colors.red);
    } else if (response.statusCode == 401) {
      GlobalToast('Unauthenticated', Colors.red);
    }
  }

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
                    prefixIcon: Icon(Icons.edit),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 20,
                  // backgroundImage: FileImage(_image),
                ),
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: () {
                  SelectImage();
                },
                child: Text("Select Image"),
              ),
              SizedBox(
                height: 20,
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

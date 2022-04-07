import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonEncode;
import 'dart:convert';
import 'dart:convert' show jsonDecode;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class AddFish extends StatelessWidget {
  @override
  TextEditingController fishnameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  // late File _image;
  final formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  String name = '';
  String description = '';
  String Api_Url = 'http://127.0.0.1:8000/api/addfish';
  String price = '';

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

  Add() async {
    Object add = {
      'name': name,
      'description': description,
      'price': price,
    };
    String Final_Fish = jsonEncode(add);

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
        body: Final_Fish);

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
    } else if (response == []) {
      GlobalToast('Duplicate data is entered ', Colors.red);
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
              key: formKey,
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
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Price',
                        prefixIcon: Icon(Icons.price_change),
                      ),
                    ),
                  ),
                  FlatButton(
                    child: Text("Submit"),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    onPressed: () => {
                      name = fishnameController.text.toString(),
                      description = descriptionController.text.toString(),
                      price = priceController.text.toString(),
                      if (name.isEmpty)
                        {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('ERROR'),
                                  content: Text('Name feild is required'),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'))
                                  ],
                                );
                              })
                        }
                      else if (description.isEmpty)
                        {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('ERROR'),
                                  content: Text('Name feild is required'),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'))
                                  ],
                                );
                              })
                        }
                      else if (price.isEmpty)
                        {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('ERROR'),
                                  content: Text('Price feild is required'),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'))
                                  ],
                                );
                              })
                        }
                      else
                        Add(),
                      fishnameController.clear(),
                      descriptionController.clear(),
                      priceController.clear(),
                           Navigator.pushNamed(context, '/fishes')
                    },
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

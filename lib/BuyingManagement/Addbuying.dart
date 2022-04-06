import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonEncode;
import 'dart:convert';
import 'dart:convert' show jsonDecode;
import 'package:fishapp/Payment/paymentGateReg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class AddBuy extends StatefulWidget {
  double price = 0.00;
  String name = '';

  AddBuy({
    required this.price,
    required this.name,
  });

  //const UpdateUser({Key? key}) : super(key: key);

  @override
  _AddBuyState createState() => _AddBuyState();
}

class _AddBuyState extends State<AddBuy> {
  @override
  TextEditingController fishnameController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  // late File _image;
  final formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  String name = '';
  String quantity = '';
  String Api_Url = 'http://127.0.0.1:8000/api/addbuy';
  String price = '';

  GlobalToast(massage, Color color) {
    return Fluttertoast.showToast(
        msg: massage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Add() async {
    Object add = {
      'fish_name': name,
      'quantity': quantity,
      'price': price,
      'user_email': 'yasi@gmail.com'
    };
    String Final_Fish = jsonEncode(add);

    final Uri url = Uri.parse(Api_Url);
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'supportsCredentials': 'true',
          'accept': 'application/json',
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

  @override
  void initState() {
    super.initState();
    setState(() {
      priceController.text = widget.price.toString();
      fishnameController.text = widget.name.toString();
    });
  }

  // const AddFish({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Buying Details",
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Text(
            "Buy Now",
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
                      readOnly: true,
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
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Quantity',
                        prefixIcon: Icon(Icons.description),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: priceController,
                      readOnly: true,
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
                      quantity = quantityController.text.toString(),
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
                      else if (quantity.isEmpty)
                        {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('ERROR'),
                                  content: Text('Quantity feild is required'),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddPayment(
                                    price: double.parse(price),
                                  ))),
                      quantityController.clear(),
                    },
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

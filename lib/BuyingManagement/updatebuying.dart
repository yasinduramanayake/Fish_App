import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonEncode;
import 'dart:convert';
import 'dart:convert' show jsonDecode;
import 'package:fishapp/Payment/paymentGateReg.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';

class UpdateBuy extends StatefulWidget {
  String id = '';
  double price = 0.00;
  String name = '';
  int quantity = 1;
  UpdateBuy({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  //const UpdateUser({Key? key}) : super(key: key);

  @override
  _UpdateBuyState createState() => _UpdateBuyState();
}

class _UpdateBuyState extends State<UpdateBuy> {
  @override
  TextEditingController fishnameController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  final LocalStorage storage = new LocalStorage('localstorage_app');
  // late File _image;
  final formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  String name = '';
  String id = '';
  int quantity = 0;
  String Api_Url = 'http://127.0.0.1:8000/api/updatebuying/';
  double price = 0.00;

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

  Update() async {
    Object update = {
      'fish_name': name,
      'quantity': quantity,
      'price': price,
      'user_email': storage.getItem('email')
    };
    String Final_Fish = jsonEncode(update);

    final Uri url = Uri.parse(Api_Url + '${id}');
    final http.Response response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
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
      Navigator.pushNamed(context, '/buyings');
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
      id = widget.id;
      priceController.text = widget.price.toString();
      quantityController.text = widget.quantity.toString();
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
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              height: 120,
              color: Colors.blue,
              child: Center(
                child: Text("Update buying form",
                    style: TextStyle(
                        fontSize: 40.0,
                        fontFamily: 'Lobster',
                        color: Colors.white)),
              ),
            ),
          ),
          SizedBox(height: 10),
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
                      quantity = int.parse(quantityController.text.toString()),
                      price = double.parse(priceController.text.toString()),
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
                      else if (quantity.toString().isEmpty)
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
                      else if (price.toString().isEmpty)
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
                        {
                          Update(),
                        }
                    },
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert' show jsonEncode;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';

class UpdatePayment extends StatefulWidget {
  double amount = 0.00;
  String id = '';
  String nic = '';
  String bank = '';
  String dob = '';
  String address = '';
  String cardName = '';
  int cardNumber = 0;
  int cvc = 0;

  UpdatePayment({
    required this.id,
    required this.nic,
    required this.amount,
    required this.bank,
    required this.cardName,
    required this.address,
    required this.dob,
    required this.cardNumber,
    required this.cvc,
  });

  //const UpdateUser({Key? key}) : super(key: key);

  @override
  _UpdatePaymentState createState() => _UpdatePaymentState();
}

class _UpdatePaymentState extends State<UpdatePayment> {
  TextEditingController nicController = new TextEditingController(); // nic
  TextEditingController dobController = new TextEditingController(); // dob
  TextEditingController addressController =
      new TextEditingController(); // address
  TextEditingController cardNameController =
      new TextEditingController(); // name on card
  TextEditingController cardNumberController =
      new TextEditingController(); // card number
  TextEditingController cvcController = new TextEditingController(); // cvc
  TextEditingController expMonthController =
      new TextEditingController(); //exp month
  TextEditingController bankController = new TextEditingController(); //bank
  TextEditingController expYearController =
      new TextEditingController(); //exp year
  final LocalStorage storage = new LocalStorage('localstorage_app');

  double amount = 0.00;
  String nic = '';
  String id = '';
  String bank = '';
  String dob = '';
  String address = '';
  String cardName = '';
  int cardNumber = 0;
  int cvc = 0;

  String Api_Url = 'http://localhost:8000/api/updatepayment/';

  // toast messages
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

  // create card
  updatePayment() async {
    Object payUser = {
      'email': storage.getItem('email'),
      'nic': nic,
      'dob': dob,
      'address': address,
      'amount': amount,
      'name_on_card': cardName,
      'card_number': cardNumber,
      'cvc': cvc,
      'bank': bank,
    };

    String PayRegUser = jsonEncode(payUser);

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
        body: PayRegUser);

    // Dispatch action depending upon
    // the server response

    if (response.statusCode == 200) {
      GlobalToast('Successfully Added', Colors.green);
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

  @override
  void initState() {
    super.initState();

    setState(() {
      id = widget.id;
      cardNameController.text = widget.cardName;
      nicController.text = widget.nic;
      bankController.text = widget.bank;
      amount = widget.amount;
      addressController.text = widget.address;
      dobController.text = widget.dob;
      cardNumberController.text = widget.cardNumber.toString();
      cvcController.text = widget.cvc.toString();
      bankController.text = widget.bank;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Save Your Card Details"),
      ),
      body: Center(
          child: Column(children: <Widget>[
        //NIC
        TextField(
          controller: nicController,
          decoration: InputDecoration(
              labelText: 'National ID number',
              prefixIcon: Icon(Icons.numbers),
              hintText: 'National ID number'),
        ),

        //DOB
        TextField(
          controller: dobController,
          decoration: InputDecoration(
              labelText: 'Date of Birth',
              prefixIcon: Icon(Icons.password),
              hintText: 'Date of Birth'),
        ),

        //Address
        TextField(
          controller: addressController,
          decoration: InputDecoration(
              labelText: 'Address',
              prefixIcon: Icon(Icons.password),
              hintText: 'Address'),
        ),

        //debit/credit Card name
        TextField(
          controller: cardNameController,
          decoration: InputDecoration(
              labelText: 'Card name',
              prefixIcon: Icon(Icons.password),
              hintText: 'Card name'),
        ),

        //debit/credit Card number
        TextField(
          controller: cardNumberController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
              labelText: 'Card number',
              prefixIcon: Icon(Icons.password),
              hintText: 'Card number'),
        ),

        //CVC
        TextField(
          controller: cvcController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
              labelText: 'CVC',
              prefixIcon: Icon(Icons.password),
              hintText: 'CVC'),
        ),

        //expMonth

        TextField(
          controller: bankController,
          decoration: InputDecoration(
              labelText: 'Bank',
              prefixIcon: Icon(Icons.password),
              hintText: 'Bank'),
        ),

        // Button
        Padding(padding: const EdgeInsets.all(8.0)),
        FlatButton(
            child: Text(
              'Pay',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // <-- Radius
            ),
            color: Colors.blueAccent,
            textColor: Colors.white,
            onPressed: () {
              cvc = int.parse(cvcController.text.toString());
              nic = nicController.text.toString();
              dob = dobController.text.toString();
              address = addressController.text.toString();
              cardName = cardNameController.text.toString();
              cardNumber = int.parse(cardNumberController.text.toString());
              bank = bankController.text.toString();

              if (nic.isEmpty) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'ERROR',
                          style: TextStyle(color: Colors.red),
                        ),
                        content: Text(
                          'Nic is required',
                          style: TextStyle(color: Colors.red),
                        ),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'))
                        ],
                      );
                    });
              } else if (nic.length > 15 && nic.length < 6) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'ERROR',
                          style: TextStyle(color: Colors.red),
                        ),
                        content: Text(
                          ' Enter Valid Nic',
                          style: TextStyle(color: Colors.red),
                        ),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'))
                        ],
                      );
                    });
              } else if (dob.isEmpty) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'ERROR',
                          style: TextStyle(color: Colors.red),
                        ),
                        content: Text(
                          'Dob feild is required',
                          style: TextStyle(color: Colors.red),
                        ),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'OK',
                              ))
                        ],
                      );
                    });
              } else if (address.isEmpty) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'ERROR',
                          style: TextStyle(color: Colors.red),
                        ),
                        content: Text(
                          'Address feild is required',
                          style: TextStyle(color: Colors.red),
                        ),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'OK',
                              ))
                        ],
                      );
                    });
              } else if (cardName.isEmpty) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'ERROR',
                          style: TextStyle(color: Colors.red),
                        ),
                        content: Text(
                          'CardName feild is required',
                          style: TextStyle(color: Colors.red),
                        ),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'OK',
                              ))
                        ],
                      );
                    });
              } else if (cardNumber.toString().isEmpty) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'ERROR',
                          style: TextStyle(color: Colors.red),
                        ),
                        content: Text(
                          'Card Number feild is required',
                          style: TextStyle(color: Colors.red),
                        ),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'OK',
                              ))
                        ],
                      );
                    });
              } else if (bank.isEmpty) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'ERROR',
                          style: TextStyle(color: Colors.red),
                        ),
                        content: Text(
                          'Bank feild is required',
                          style: TextStyle(color: Colors.red),
                        ),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'OK',
                              ))
                        ],
                      );
                    });
              } else if (cardNumber.toString().length != 16) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'ERROR',
                          style: TextStyle(color: Colors.red),
                        ),
                        content: Text(
                          'Enter valid Card Number',
                          style: TextStyle(color: Colors.red),
                        ),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'OK',
                              ))
                        ],
                      );
                    });
              } else {
                this.updatePayment();
                Navigator.pushNamed(context, '/payments');
              }
            }),
      ])),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert' show jsonEncode;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';

class AddPayment extends StatefulWidget {
  double price = 0.00;

  AddPayment({
    required this.price,
  });

  //const UpdateUser({Key? key}) : super(key: key);

  @override
  _AddPaymentState createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
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

  double amount = 0.00;
  String nic = '';
  String bank = '';
  String dob = '';
  String address = '';
  String cardName = '';
  String cardNumber = '';
  String cvc = '';
  String expMonth = '';
  String expYear = '';

  String Api_Url = 'http://localhost:8000/api/addpayment';
  final LocalStorage storage = new LocalStorage('localstorage_app');

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
  createPayment() async {
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
      'expire_month': expMonth,
      'expire_year': expYear
    };

    String PayRegUser = jsonEncode(payUser);

    final Uri url = Uri.parse(Api_Url);
    final http.Response response = await http.post(url,
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
      Navigator.pushNamed(context, '/payments');
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
      amount = widget.price;
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
          keyboardType: TextInputType.datetime,
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
          controller: expMonthController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
              labelText: 'Exp month',
              prefixIcon: Icon(Icons.password),
              hintText: 'Exp month'),
        ),

        //expMonth
        TextField(
          controller: expYearController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
              labelText: 'Exp Year',
              prefixIcon: Icon(Icons.password),
              hintText: 'Exp Year'),
        ),

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
              cvc = cvcController.text.toString();
              nic = nicController.text.toString();
              dob = dobController.text.toString();
              address = addressController.text.toString();
              cardName = cardNameController.text.toString();
              cardNumber = cardNumberController.text.toString();
              bank = bankController.text.toString();
              expMonth = expMonthController.text.toString();
              expYear = expYearController.text.toString();
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
              } else if (cardNumber.isEmpty) {
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
              } else if (expMonth.isEmpty) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'ERROR',
                          style: TextStyle(color: Colors.red),
                        ),
                        content: Text(
                          'Exp Month feild is required',
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
              } else if (expYear.isEmpty) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'ERROR',
                          style: TextStyle(color: Colors.red),
                        ),
                        content: Text(
                          'Exp Year feild is required',
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
              } else if (cvc.length >= 3) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'ERROR',
                          style: TextStyle(color: Colors.red),
                        ),
                        content: Text(
                          'Cvc feild is not valid',
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
              } else if (cardNumber.length != 16) {
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
                this.createPayment();

                addressController.clear();
                cardNameController.clear();
                cardNumberController.clear();
                expMonthController.clear();
                expYearController.clear();
                dobController.clear();
                nicController.clear();
                bankController.clear();
                cvcController.clear();
              }
            }),
      ])),
    );
  }
}

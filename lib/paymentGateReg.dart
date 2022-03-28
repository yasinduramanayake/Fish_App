import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert' show jsonEncode;
import 'package:fluttertoast/fluttertoast.dart';

class PaymentRegister extends StatelessWidget {
  TextEditingController firstNameController =
      new TextEditingController(); //first name
  TextEditingController lastNameController =
      new TextEditingController(); //last name
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
  TextEditingController expYearController =
      new TextEditingController(); //exp year

  String firstName = '';
  String lastName = '';
  String nic = '';
  String dob = '';
  String address = '';
  String cardName = '';
  String cardNumber = '';
  String cvc = '';
  String expMonth = '';
  String expYear = '';

  String Api_Url = 'http://localhost:8000/api/payregister';

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
  createUser() async {
    Object payUser = {
      'firstName': firstName,
      'lastName': lastName,
      'nic': nic,
      'dob': dob,
      'address': address,
      'cardName': cardName,
      'cardNumber': cardNumber,
      'cvc': cvc,
      'expMonth': expMonth,
      'expYear': expYear
    };

    String PayRegUser = jsonEncode(payUser);

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Save Your Card Details"),
      ),
      body: Center(
          child: Column(children: <Widget>[
        //firstName
        Padding(
          padding: EdgeInsets.all(16.0),
          child: TextField(
            controller: firstNameController,
            decoration: InputDecoration(
                labelText: 'First name',
                prefixIcon: Icon(Icons.person rounded),
                hintText: 'First name'),
          ),
        ),

        // Button
        Padding(
          padding: EdgeInsets.all(16.0),
          child: FlatButton(
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // <-- Radius
              ),
              color: Colors.blueAccent,
              height: 40,
              textColor: Colors.white,
              onPressed: () {
                name = nameController.text.toString();
                email = emailController.text.toString();
                password = passwordController.text.toString();
                mobile = mobileController.text.toString();
                password_confirmation =
                passowrdconfirmController.text.toString();

                if (name.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'ERROR',
                            style: TextStyle(color: Colors.red),
                          ),
                          content: Text('Name feild is required',
                              style: TextStyle(color: Colors.red)),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'))
                          ],
                        );
                      });
                } else if (email.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'ERROR',
                            style: TextStyle(color: Colors.red),
                          ),
                          content: Text('Email feild is required',
                              style: TextStyle(color: Colors.red)),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'))
                          ],
                        );
                      });
                } else if (!email.contains('@')) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'ERROR',
                            style: TextStyle(color: Colors.red),
                          ),
                          content: Text(
                            'Enter a valid email address',
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
                } else if (password.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'ERROR',
                            style: TextStyle(color: Colors.red),
                          ),
                          content: Text(
                            'Enter a valid password',
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
                } else if (password.length < 6) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'ERROR',
                            style: TextStyle(color: Colors.red),
                          ),
                          content: Text(
                            'Enter password with minimum 6 characters',
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
                } else if (password_confirmation != password) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'ERROR',
                            style: TextStyle(color: Colors.red),
                          ),
                          content: Text(
                            'Password not match',
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
                } else if (mobile.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'ERROR',
                            style: TextStyle(color: Colors.red),
                          ),
                          content: Text(
                            'mobile feild is required',
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
                } else if (mobile.length > 10 || mobile.length < 10) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'ERROR',
                            style: TextStyle(color: Colors.red),
                          ),
                          content: Text(
                            'Enter valid numbers length',
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
                  this.createUser();
                  email = '';
                  password = '';
                  name = '';
                  mobile = '';
                  Navigator.pushNamed(context, '/login');
                }
              }),
        )
      ])),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController passowrdconfirmController = new TextEditingController();

  String _selectedGender = 'Admin';
  String email = '';
  String password = '';
  String name = '';
  String mobile = '';
  String password_confirmation = '';
  String Api_Url = 'http://localhost:8000/api/adduser';

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

  addUser() async {
    Object user = {
      'email': email,
      'password': password,
      'mobile': mobile,
      'name': name,
      'role': _selectedGender,
      'password_confirmation': password_confirmation
    };
    String Final_User = jsonEncode(user);

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
        body: Final_User);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add User",
        ),
      ),
      body: Column(
        children: <Widget>[
         
          Text(
            "Add User Form",
            style: TextStyle(fontSize: 30.0),
          ),
          Form(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.edit),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.edit),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(8.0),
                // mobile
                child: TextField(
                  controller: mobileController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mobile',
                      prefixIcon: Icon(Icons.phone),
                      hintText: 'Enter Mobile'),
                ),
              ),

              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const Text('Please let us know your Role:'),
                      ListTile(
                        leading: Radio<String>(
                          value: 'Admin',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                        title: const Text('Admin'),
                      ),
                      ListTile(
                        leading: Radio<String>(
                          value: 'User',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                        title: const Text('User'),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.password),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: passowrdconfirmController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.confirmation_num),
                  ),
                ),
              ),

              // ignore: deprecated_member_use

              FlatButton(
                  child: Text("Submit"),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
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
                      this.addUser();

                      Navigator.pushNamed(context, '/users');
                    }
                  })
            ],
          )),
        ],
      ),
    );
  }
}

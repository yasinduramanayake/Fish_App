import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class AddUser extends StatelessWidget {
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  //const AddUser({ Key? key }) : super(key: key);
  String firstname = '';
  String lastname = '';
  String username = '';
  String password = '';
  String confirmPassword = '';
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

  addUser() async {
    Object user = {
      'firstname': firstname,
      'lastname': lastname,
      'password': password,
      'username': username,
      'confirmPassword': 'confirmPassword',
    };
    String Final_User = jsonEncode(user);

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
          SizedBox(height: 10),
          Text(
            "Add User Form",
            style: TextStyle(fontSize: 30.0),
          ),
          Form(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'First Name',
                    prefixIcon: Icon(Icons.edit),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last Name',
                    prefixIcon: Icon(Icons.edit),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
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
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.confirmation_num),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
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
              // ignore: deprecated_member_use
              SizedBox(
                height: 20,
              ),
              FlatButton(
                child: Text("Submit"),
                color: Color.fromARGB(255, 0, 24, 66),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                onPressed: () {
                  firstname = firstNameController.text.toString();
                  lastname = lastNameController.text.toString();
                  password = passwordController.text.toString();
                  username = usernameController.text.toString();
                  confirmPassword = confirmPasswordController.text.toString();

                  if (firstname.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'ERROR',
                              style: TextStyle(color: Colors.red),
                            ),
                            content: Text('First Name feild is required',
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
                  } else if (lastname.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'ERROR',
                              style: TextStyle(color: Colors.red),
                            ),
                            content: Text('Last Name feild is required',
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
                  } else if (username.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'ERROR',
                              style: TextStyle(color: Colors.red),
                            ),
                            content: Text('Username feild is required',
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
                  } else if (password.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'ERROR',
                              style: TextStyle(color: Colors.red),
                            ),
                            content: Text('Last Name feild is required',
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
                  } else if (confirmPassword.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'ERROR',
                              style: TextStyle(color: Colors.red),
                            ),
                            content: Text('Confirm Password feild is required',
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
                  } else if (confirmPassword != password) {
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
                  }
                },
              )
            ],
          )),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert' show jsonEncode;
import 'dart:convert' show jsonDecode;
import 'package:localstorage/localstorage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatelessWidget {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController passowrdconfirmController = new TextEditingController();

  String email = '';
  String password = '';
  String name = '';
  String mobile = '';
  String password_confirmation = '';
  String Api_Url = 'http://localhost:8000/api/register';
  final LocalStorage storage = new LocalStorage('localstorage_app');
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
    storage.setItem('name', 'Abolfazl');
    Object user = {
      'email': email,
      'password': password,
      'mobile': mobile,
      'name': name,
      'role': 'user',
      'password_confirmation': password_confirmation
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
    // // the server response

    print(storage.getItem('name'));
    if (response.statusCode == 200) {
      GlobalToast('Successful Added', Colors.green);
    } else if (response.statusCode == 422) {
      GlobalToast('Given data is invalid', Color.fromARGB(255, 236, 40, 26));
    } else if (response.statusCode == 500) {
      GlobalToast('Internal server error', Color.fromARGB(255, 255, 17, 0));
    } else if (response.statusCode == 400) {
      GlobalToast('Bad request', Colors.yellow);
    } else if (response.statusCode == 404) {
      GlobalToast('404 not found', Colors.red);
    } else if (response.statusCode == 401) {
      GlobalToast('Unauthenticated', Colors.red);
    }
    email = password = ' ';
    name = ' ';
    password_confirmation = ' ';
    mobile = ' ';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Center(
          child: Column(children: <Widget>[
        // user name
        Padding(
          padding: EdgeInsets.all(16.0),
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(
                labelText: 'User Name',
                prefixIcon: Icon(Icons.create),
                hintText: 'Enter User Name'),
          ),
        ),
        // email
        Padding(
          padding: EdgeInsets.all(16.0),
          // mobile
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
                labelText: 'User Email',
                prefixIcon: Icon(Icons.email),
                hintText: 'Enter Email'),
          ),
        ),
        // password

        Padding(
          padding: EdgeInsets.all(16.0),
          child: TextField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.password),
                hintText: 'Enter Password'),
          ),
        ),
        // password Confirmation
        Padding(
          padding: EdgeInsets.all(16.0),
          child: TextField(
            obscureText: true,
            controller: passowrdconfirmController,
            decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.confirmation_num),
                hintText: 'Enter Password'),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(16.0),
          // mobile
          child: TextField(
            controller: mobileController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: 'Mobile',
                prefixIcon: Icon(Icons.phone),
                hintText: 'Enter Mobile'),
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

                  Navigator.pushNamed(context, '/login');
                }
              }),
        )
      ])),
    );
  }
}

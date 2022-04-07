import 'dart:convert';

import 'package:fishapp/UserManagement/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class UpdateUser extends StatefulWidget {
  String name;
  String email;
  String id;
  String mobile;
  String role;

  UpdateUser(
      {required this.name,
      required this.email,
      required this.id,
      required this.mobile,
      required this.role});

  //const UpdateUser({Key? key}) : super(key: key);

  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();

  late String id1;
  String name = '';
  String email = '';
  String role = '';
  String mobile = '';
  String Api_Url = 'http://localhost:8000/api/updateuser/';

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

  updateUser() async {
    Object user = {
      'name': name,
      'mobile': mobile,
      'role': role,
      'email': email,
    };
    String Final_User = jsonEncode(user);

    final Uri url = Uri.parse(Api_Url + '${id1}');
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
        body: Final_User);

    // Dispatch action depending upon
    // the server response
    if (response.statusCode == 200) {
      GlobalToast('Successful Updated', Colors.green);
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
    // TODO: implement initState
    super.initState();

    setState(() {
      id1 = widget.id;
      nameController.text = widget.name;
      emailController.text = widget.email;
      mobileController.text = widget.mobile.toString();
      role = widget.role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update User"),
      ),
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              height: 50,
              color: Colors.blue,
            ),
          ),
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
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.edit),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'email',
                    prefixIcon: Icon(Icons.edit),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: mobileController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mobile',
                    prefixIcon: Icon(Icons.person),
                  ),
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
                          groupValue: role,
                          onChanged: (value) {
                            setState(() {
                              role = value!;
                            });
                          },
                        ),
                        title: const Text('Admin'),
                      ),
                      ListTile(
                        leading: Radio<String>(
                          value: 'User',
                          groupValue: role,
                          onChanged: (value) {
                            setState(() {
                              role = value!;
                            });
                          },
                        ),
                        title: const Text('User'),
                      ),
                    ],
                  )),
              FlatButton(
                  child: Text("Submit"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  onPressed: () {
                    name = nameController.text.toString();
                    email = emailController.text.toString();

                    mobile = mobileController.text.toString();

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
                      this.updateUser();

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

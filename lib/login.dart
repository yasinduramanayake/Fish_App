import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Sign In"),
       
        
      ),
      body: Column(
        children: [
          // image insert
          Form(
              child: Column(
            children: <Widget>[
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.password),
                ),
              ),
              FlatButton(
                child: Text(
                  'LogIn',
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.blueAccent,
                textColor: Colors.white,
                onPressed: () {
                  email = emailController.text.toString();
                  password = passwordController.text.toString();

                  if (email.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('ERROR'),
                            content: Text('Email feild is required'),
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
                            title: Text('ERROR'),
                            content: Text('Enter a valid email address'),
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
                            title: Text('ERROR'),
                            content: Text('Enter a valid password'),
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
                            title: Text('ERROR'),
                            content: Text(
                                'Enter password with minimum 6 characters'),
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
              ),
            ],
          )),
        ],
      ),

      // Text(
      //   "                                                                           ",
      //   overflow: TextOverflow.ellipsis,
      //   maxLines: 51,
      // ),
      // Expanded(
      //   child: ListView(
      //     children: <Widget>[
      //       ListTile(
      //         leading: Icon(Icons.map),
      //         title: Text('Map'),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.subway),
      //         title: Text('Subway'),
      //       ),
      //     ],
      //   ),

      // ),],)
    );
  }
}

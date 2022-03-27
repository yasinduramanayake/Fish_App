import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatelessWidget {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Center(
          child: Column(children: <Widget>[
        // user name
        Padding(padding: EdgeInsets.all(16.0)),
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'User Name',
            prefixIcon: Icon(Icons.create),
          ),
        ),

        // email
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'User Email',
            prefixIcon: Icon(Icons.email),
          ),
        ),

        // password

        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.password),
          ),
        ),

        // Button
        Padding(padding: EdgeInsets.all(16.0)),

        FlatButton(
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
            onPressed: () {}),
      ])),
    );
  }
}

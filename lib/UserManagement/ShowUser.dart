import 'package:fishapp/UserManagement/User.dart';
import 'package:fishapp/UserManagement/updateUser.dart';
import 'package:flutter/material.dart';

class ShowUser extends StatefulWidget {
  String name;
  String email;
  String username;
  // User user;

  ShowUser({required this.name, required this.email, required this.username});

  @override
  State<ShowUser> createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      User user = User(widget.name, widget.email, widget.username);
      String name = widget.name;
      String email = widget.email;
      String username = widget.username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Details",
        ),
      ),
      body: Column(children: [
        SizedBox(height: 30),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40), // if you need this
            side: BorderSide(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal: 50)),
              Text("Name: "),
              Text(widget.name),
              SizedBox(
                height: 20,
              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 50)),
              Text("User name: "),
              Text(widget.username),
              SizedBox(
                height: 20,
              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 50)),
              Text("Email: "),
              Text(widget.email),
              SizedBox(
                height: 20,
              ),
              Column(
                verticalDirection: VerticalDirection.down,
                children: [
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateUser(
                                    name: widget.name,
                                    email: widget.email,
                                    username: widget.username,
                                  )));
                    },
                    child: Text("Update"),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text("Delete"),
                    color: Colors.redAccent,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}

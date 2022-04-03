import 'dart:convert';

import 'package:fishapp/UserManagement/User.dart';
import 'package:fishapp/UserManagement/updateUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  List<User> users = [];

  Future<List<User>?> getUsersData() async {
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);

    //add users to the list
    for (var u in jsonData) {
      User user = User(u['name'], u['email'], u['username']);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Users List'),
        ),
        body: Container(
          //snapshot - data coming from the api
          child: FutureBuilder<List<User>?>(
              future: getUsersData(),
              builder: (context, snapshot) {
                List<User>? list = snapshot.data;
                if (list == null) {
                  return Container(
                    child: Center(
                      child: Text('loading....'),
                    ),
                  );
                } else {
                  // List<User> userlist = snapshot.data;
                  return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, i) {
                        return Slidable(
                          key: ValueKey(i),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            tileColor: Colors.greenAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            title: Text(list[i].name),
                            subtitle: Text(list[i].username),
                            trailing: Text(list[i].email),
                          ),
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            // extentRatio: 0.5,
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(
                                  //         content:
                                  //             Text('edit ${users[i].name}')));

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpdateUser(
                                                name: list[i].name,
                                                username: list[i].username,
                                                email: list[i].email,
                                              )));
                                },
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: 'Edit',
                              ),
                              SlidableAction(
                                // flex: 2,
                                onPressed: (context) {
                                  setState(() {
                                    users.removeAt(i);
                                  });
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                        );
                      });
                }
              }),
        ));
  }
}

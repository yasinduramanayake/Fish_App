import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
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
  String Api_Url = 'http://localhost:8000/api/';
  Future<List<User>?> getUsersData() async {
    final Uri url = Uri.parse(Api_Url + 'users');
    final http.Response response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    var data = jsonData['data']['data'];
    //add users to the list
    for (var u in data) {
      User user = User(
          u['id'].toString(), u['name'], u['mobile'], u['email'], u['role']);
      users.add(user);
    }

    return users;
  }

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

  delete(id) async {
    final Uri url = Uri.parse(Api_Url + 'deleteuser/${id}');
     final http.Response response = await http.delete(url);

     if (response.statusCode == 200) {
      GlobalToast('Successful Deleted', Colors.green);
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
                            subtitle: Text(list[i].name),
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
                                                email: list[i].email,
                                                id: list[i].id,
                                                mobile: list[i].mobile,
                                                role: list[i].role,
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
                                  this.delete(list[i].id);

                                  Navigator.pushNamed(context, '/users');
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

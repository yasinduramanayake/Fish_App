import 'dart:convert';
import 'package:fishapp/FishManagement/updatefish.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fishapp/FishManagement/Fish.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

class FishList extends StatefulWidget {
  const FishList({Key? key}) : super(key: key);

  @override
  State<FishList> createState() => _FishListState();
}

class _FishListState extends State<FishList> {
  List<Fish> fishes = [];
  String Api_Url = 'http://localhost:8000/api/';
  Future<List<Fish>?> getUsersData() async {
    final Uri url = Uri.parse(Api_Url + 'fishes');
    final http.Response response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    var data = jsonData['data']['data'];
    //add users to the list
    for (var u in data) {
      Fish fish =
          Fish(u['id'].toString(), u['name'], u['description'], u['price']);
      fishes.add(fish);
    }

    return fishes;
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
    final Uri url = Uri.parse(Api_Url + 'deletefish/${id}');
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
          title: Text('Fish List'),
        ),
        body: Container(
          //snapshot - data coming from the api
          child: FutureBuilder<List<Fish>?>(
              future: getUsersData(),
              builder: (context, snapshot) {
                List<Fish>? list = snapshot.data;
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
                                          builder: (context) => UpdateFish(
                                                name: list[i].name,
                                                price: list[i].price,
                                                id: list[i].id,
                                                description: list[i].description,
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

                                  Navigator.pushNamed(context, '/fishes');
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

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fishapp/BuyingManagement/Buying.dart';
import 'package:fishapp/BuyingManagement/showbuying.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

class BuyingList extends StatefulWidget {
  const BuyingList({Key? key}) : super(key: key);

  @override
  State<BuyingList> createState() => _BuyingListState();
}

class _BuyingListState extends State<BuyingList> {
  List<Buying> buyings = [];
  String Api_Url = 'http://localhost:8000/api/';
  Future<List<Buying>?> getUsersData() async {
    final Uri url = Uri.parse(Api_Url + 'buyings');
    final http.Response response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    var data = jsonData['data']['data'];
    //add users to the list
    for (var u in data) {
      Buying user = Buying(u['id'].toString(), u['fish_name'], u['quantity'],
          u['user_email'], u['price']);
      buyings.add(user);
    }

    return buyings;
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
    final Uri url = Uri.parse(Api_Url + 'deletebuying/${id}');
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
          title: Text('Buying List'),
        ),
        body: Container(
          //snapshot - data coming from the api
          child: FutureBuilder<List<Buying>?>(
              future: getUsersData(),
              builder: (context, snapshot) {
                List<Buying>? list = snapshot.data;
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
                            trailing: Text(list[i].price.toString()),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowBuying(
                                            name: list[i].name,
                                            email: list[i].email,
                                            id: list[i].id,
                                            quantity: list[i].quantity,
                                            price: list[i].price,
                                          )));
                            },
                          ),
                        );
                      });

                  // ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //         content:
                  //             Text('edit ${users[i].name}')));

                }
              }),
        ));
  }
}

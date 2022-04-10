import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Adminmenu extends StatelessWidget {
  final LocalStorage storage = new LocalStorage('localstorage_app');
  logout() {
    storage.clear();
    GlobalToast('Successful logged out', Colors.green);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Menu"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Users'),
            onTap: () {
              Navigator.pushNamed(context, '/users');
            },
          ),
          ListTile(
            leading: Icon(Icons.water),
            title: Text('Fish Management'),
            onTap: () {
              Navigator.pushNamed(context, '/fishes');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              this.logout();
              Navigator.pushNamed(context, '/');
            },
          ),
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

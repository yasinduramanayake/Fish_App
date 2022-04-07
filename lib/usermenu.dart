import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class Usermenu extends StatelessWidget {
  final LocalStorage storage = new LocalStorage('localstorage_app');
  logout() {
    storage.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('All Fishes'),
            onTap: () {
              Navigator.pushNamed(context, '/userFishlist');
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('My cart'),
            onTap: () {
              Navigator.pushNamed(context, '/buyings');
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('My Payments'),
            onTap: () {
              Navigator.pushNamed(context, '/payments');
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

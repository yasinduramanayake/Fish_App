import 'dart:convert';
import 'dart:html';
import 'package:fishapp/BuyingManagement/Addbuying.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ShowFish extends StatefulWidget {
  String name;
  String description;
  String id;
  double price;

  ShowFish({
    required this.name,
    required this.description,
    required this.id,
    required this.price,
  });

  //const UpdateUser({Key? key}) : super(key: key);

  @override
  _ShowFishState createState() => _ShowFishState();
}

class _ShowFishState extends State<ShowFish> {
  String Name = 'bgvfd';
  String Description = 't4r3e';
  double Price = 1.00;
  String id = 'gtfr';

  @override
  void initState() {
    super.initState();

    setState(() {
      id = widget.id;
      Name = widget.name;
      Description = widget.description;
      Price = widget.price;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Selected Fish",
          ),
        ),
        body: Column(children: [
          Padding(
            padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Fish Name = ${Name}',
                style: TextStyle(color: Colors.white),
              ),
            ),
            color: Colors.green,
          ),
          Card(
            child: ListTile(
              title: Text(
                'Fish Description = ${Description}',
                style: TextStyle(color: Colors.white),
              ),
            ),
            color: Colors.green,
          ),
          Card(
            child: ListTile(
              title: Text(
                'Fish Price = ${Price}',
                style: TextStyle(color: Colors.white),
              ),
            ),
            color: Colors.green,
          ),
          Expanded(
            flex: 5,
            child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Center(
                    child: FlatButton(
                  child: Text(
                    "Buy Now",
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
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddBuy(price: Price, name: Name)))
                  },
                ))),
          ),
        ]));
  }
}

import 'dart:convert';
import 'dart:html';
import 'package:fishapp/BuyingManagement/updatebuying.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ShowBuying extends StatefulWidget {
  String name;
  String email;
  String id;
  int quantity;
  double price;


  ShowBuying({
    required this.name,
    required this.email,
    required this.id,
    required this.price,
    required this.quantity,
  });

  //const UpdateUser({Key? key}) : super(key: key);

  @override
  _ShowBuyingState createState() => _ShowBuyingState();
}

class _ShowBuyingState extends State<ShowBuying> {
  String Name = 'bgvfd';
  String email = 't4r3e';
  double Price = 1.00;
  String id = 'gtfr';
  int quantity = 0;
  String cretaed_at = '';
  String Api_Url = 'http://localhost:8000/api/deletebuying/';

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

  delete() async {
    final Uri url = Uri.parse(Api_Url + '${id}');
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
  void initState() {
    super.initState();

    setState(() {
      id = widget.id;
      Name = widget.name;
      email = widget.email;
      Price = widget.price;
      quantity = widget.quantity;
    
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Selected Buying",
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(1.0),
                child: Center(
                  child: Text(
                    'Fish Name : ${Name}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(1.0),
                child: Center(
                  child: Text(
                    'Your Email : ${email}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(1.0),
                child: Center(
                  child: Text(
                    'Fish Price : ${Price.toString()}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                      child: FlatButton(
                    child: Text("Update", style: TextStyle(
                        fontSize: 20.0,
                      ),),
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
                              builder: (context) => UpdateBuy(
                                    id: id,
                                    name: Name,
                                    price: Price,
                                    quantity: quantity,
                                  )))
                    },
                  ))),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                      child: FlatButton(
                    child: Text("Delete"),
                    onPressed: () => {this.delete()},
                  ))),
            ),
          ],
        ));
  }
}

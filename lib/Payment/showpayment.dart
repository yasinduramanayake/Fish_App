import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:fishapp/Payment/updatepayment.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ShowPayment extends StatefulWidget {
  double amount = 0.00;
  String id = '';
  String nic = '';
  String bank = '';
  String dob = '';
  String address = '';
  String cardName = '';
  int cardNumber = 0;
  int cvc = 0;

  ShowPayment({
    required this.id,
    required this.nic,
    required this.amount,
    required this.bank,
    required this.cardName,
    required this.address,
    required this.dob,
    required this.cardNumber,
    required this.cvc,
  });

  //const UpdateUser({Key? key}) : super(key: key);

  @override
  _ShowPaymentState createState() => _ShowPaymentState();
}

class _ShowPaymentState extends State<ShowPayment> {
  double amount = 0.00;
  String id = '';
  String nic = '';
  String bank = '';
  String dob = '';
  String address = '';
  String cardName = '';
  int cardNumber = 0;
  int cvc = 0;

  String Api_Url = 'http://localhost:8000/api/deletepayment/';

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
      Navigator.pushNamed(context, '/payments');
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
      cardName = widget.cardName;
      nic = widget.nic;
      bank = widget.bank;
      amount = widget.amount;
      address = widget.address;
      dob = widget.dob;
      cardNumber = widget.cardNumber;
      cvc = widget.cvc;
      bank = widget.bank;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Your Payments",
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
            ),
            Card(
              child: ListTile(
                title: Text(
                  'Card Name = ${cardName}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              color: Colors.green,
            ),
            Card(
              child: ListTile(
                title: Text(
                  'Bank = ${bank}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              color: Colors.green,
            ),
            Card(
              child: ListTile(
                title: Text(
                  ' Address = ${address}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              color: Colors.green,
            ),
            Card(
              child: ListTile(
                title: Text(
                  'Card Number = ${cardNumber}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              color: Colors.green,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
            FlatButton(
              child: Text(
                "Update",
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
                        builder: (context) => UpdatePayment(
                              id: id,
                              nic: nic,
                              amount: amount,
                              bank: bank,
                              cardName: cardName,
                              address: address,
                              dob: dob,
                              cardNumber: cardNumber,
                              cvc: cvc,
                            )))
              },
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
            FlatButton(
              child: Text(
                "Delete",
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
                this.delete(),
              },
            ),
          ],
        ));
  }
}

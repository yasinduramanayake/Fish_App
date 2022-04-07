import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fishapp/Payment/Payment.dart';
import 'package:fishapp/Payment/showpayment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class PaymentList extends StatefulWidget {
  const PaymentList({Key? key}) : super(key: key);

  @override
  State<PaymentList> createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  List<Payment> payments = [];
   final LocalStorage storage = new LocalStorage('localstorage_app');
  String Api_Url = 'http://localhost:8000/api/';
  Future<List<Payment>?> getUsersData() async {
    final Uri url = Uri.parse(Api_Url + 'payments?filter[email] =${storage.getItem('email')}');
    final http.Response response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    var data = jsonData['data']['data'];
    //add users to the list
    for (var u in data) {
      Payment payment = Payment(
          u['id'].toString(),
          u['dob'],
          u['nic'],
          u['name_on_card'],
          u['bank'],
          u['cvc'],
          u['amount'],
          u['card_number'],
          u['address']);
      payments.add(payment);
    }

    return payments;
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
    final Uri url = Uri.parse(Api_Url + 'deletePayment/${id}');
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
          title: Text('Payments List'),
        ),
        body: Container(
          //snapshot - data coming from the api
          child: FutureBuilder<List<Payment>?>(
              future: getUsersData(),
              builder: (context, snapshot) {
                List<Payment>? list = snapshot.data;
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
                            title: Text(list[i].bank),
                            subtitle: Text(list[i].address),
                            trailing: Text(list[i].price.toString()),
                            onTap: () {
                               
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowPayment(
                                            id: list[i].id,
                                            nic: list[i].nic,
                                            amount: list[i].price,
                                            bank: list[i].bank,
                                            cardName: list[i].cardname,
                                            address: list[i].address,
                                            dob: list[i].dob,
                                            cardNumber: list[i].cardnumber,
                                            cvc: list[i].cvc,
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

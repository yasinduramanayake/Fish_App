import 'package:fishapp/data/fish.dart';
import 'package:flutter/material.dart';

class FishList extends StatelessWidget {
  final List<Fish> fishes;
  const FishList({Key? key, required this.fishes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return Card(
        elevation: 5,
        child: ListTile(
          leading: Image.asset('aa'),
          title: Text(fishes[index].name),
          subtitle: Text(fishes[index].description),
        ),
      );
    });
  }
}

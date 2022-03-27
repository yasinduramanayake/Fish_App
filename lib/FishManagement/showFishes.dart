import 'package:fishapp/FishManagement/fish_list.dart';
import 'package:fishapp/data/fish.dart';
import 'package:flutter/material.dart';

class ShowFishes extends StatefulWidget {
  const ShowFishes({Key? key}) : super(key: key);

  @override
  _ShowFishesState createState() => _ShowFishesState();
}

class _ShowFishesState extends State<ShowFishes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fish Details"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.navigate_next),
          )
        ],
      ),
      body: FutureBuilder<List<Fish>?>(
        // future: _postService.getPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //create our own list widget
            List<Fish>? posts = snapshot.data;
            return posts != null
                ? FishList(
                    fishes: [],
                  )
                : const Text(
                    "Empty"); // new PostList(posts: posts) use without new

          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

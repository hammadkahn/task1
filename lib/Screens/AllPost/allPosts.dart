import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../Models/postModel.dart';
import '../../Models/usermodel.dart';

class AllPosts extends StatelessWidget {
  const AllPosts({Key? key, required this.postlist1}) : super(key: key);
  final List<usermodel> postlist1;
  @override
  Widget build(BuildContext context) {
    List<PostsModel> postlist = [];
    Future<List<PostsModel>> getPostApi() async {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      var Data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        for (Map i in Data) {
          postlist.add(PostsModel.fromJson(i));
        }
        return postlist;
      } else {
        throw Exception('Failed to load post');
      }
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFAF0917),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getPostApi(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("Loading data...");
                    } else {
                      return ListView.builder(
                          itemCount: postlist.length,
                          itemBuilder: ((context, index) {
                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(postlist[index].title.toString(),
                                      style: TextStyle(
                                          color: postlist[index].id ==
                                                  postlist1[0].id
                                              ? Color(0xffE43228)
                                              : Colors.black,
                                          fontWeight: postlist[index].id ==
                                                  postlist1[0].id
                                              ? FontWeight.bold
                                              : FontWeight.w400)),
                                  SizedBox(height: 5),
                                  Text(postlist[index].body.toString()),
                                  Divider(
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            );
                          }));
                    }
                  }),
            ),
          ],
        ),
      )),
    );
  }
}

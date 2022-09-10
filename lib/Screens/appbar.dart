import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:task1/Screens/AllPost/allPosts.dart';
import 'package:task1/Screens/profile/profile.dart';

import '../Locator.dart';
import '../Models/usermodel.dart';
import '../services/global_service.dart';

class Appbar_custom extends StatefulWidget {
  Appbar_custom({Key? key}) : super(key: key);

  @override
  State<Appbar_custom> createState() => _Appbar_customState();
}

class _Appbar_customState extends State<Appbar_custom> {
  final _globalService = locator<GlobalService>();
  bool isLoading = false;
  List<usermodel> postlist1 = [];
  @override
  void initState() {
    getUserApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Lorem Ipsum'),
            backgroundColor: Color(0xFFAF0917),
            automaticallyImplyLeading: false,
            leading: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
            ],
            bottom: TabBar(indicatorColor: Colors.white, tabs: [
              Tab(
                text: 'All Posts',
              ),
              Tab(
                text: 'Profile',
              )
            ]),
          ),
          body: isLoading == true
              ? Center(child: CircularProgressIndicator())
              : TabBarView(
                  children: [
                    AllPosts(
                      postlist1: postlist1,
                    ),
                    Profile()
                  ],
                )),
    );
  }

  Future<usermodel> getUserApi() async {
    isLoading = true;
    setState(() {});
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var Data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in Data) {
        postlist1.add(usermodel.fromJson(i));
      }
      var a = postlist1
          .where((element) => element.email == _globalService.email)
          .toList();
      postlist1 = a;

      setState(() {
        isLoading = false;
        print("helllllll");
      });
      return a[0];
    } else {
      throw Exception('Failed to load post');
    }
  }
}

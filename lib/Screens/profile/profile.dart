import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:task1/services/global_service.dart';

import '../../Locator.dart';
import '../../Models/usermodel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  final _globalService = locator<GlobalService>();

  @override
  Widget build(BuildContext context) {
    List<usermodel> postlist1 = [];
    Future<usermodel> getUserApi() async {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      var Data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        for (Map i in Data) {
          postlist1.add(usermodel.fromJson(i));
        }
        var a = postlist1
            .where((element) => element.email == _globalService.email)
            .toList();
        postlist1 = a;
        return a[0];
      } else {
        throw Exception('Failed to load post');
      }
    }

    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getUserApi(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("Loading data...");
                    } else {
                      return ListView.builder(
                          itemCount: postlist1.length,
                          itemBuilder: ((context, index) {
                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Name',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                      Text(postlist1[index].name.toString()),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Username',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          postlist1[index].username.toString()),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text('Address',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                      Spacer(),
                                      Text(postlist1[index]
                                              .address!
                                              .street
                                              .toString() +
                                          ","),
                                      Text(postlist1[index]
                                              .address!
                                              .suite
                                              .toString() +
                                          ","),
                                      Text(postlist1[index]
                                          .address!
                                          .city
                                          .toString()),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Zipcode',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                      Text(postlist1[index]
                                          .address!
                                          .zipcode
                                          .toString()),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
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

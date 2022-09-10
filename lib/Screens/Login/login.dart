import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:task1/Screens/appbar.dart';
import 'package:task1/services/global_service.dart';

import '../../Locator.dart';
import '../../Models/usermodel.dart';
import '../AllPost/allPosts.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _globalService = locator<GlobalService>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.jpeg',
              width: 150,
            ),
            SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height * 72 / 1257,
              width: MediaQuery.of(context).size.width * 442 / 584,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 15),
                  border: InputBorder.none,
                  hintText: 'Email',
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height * 72 / 1257,
              width: MediaQuery.of(context).size.width * 442 / 584,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 15),
                  border: InputBorder.none,
                  hintText: 'Password',
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                _globalService.email = emailController.text;
                login(emailController.text.toString(),
                    passwordController.text.toString());
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 72 / 1257,
                width: MediaQuery.of(context).size.width * 442 / 584,
                decoration: BoxDecoration(
                  color: Color(0xFFE43228),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                    child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<usermodel> postlist = [];
  Future<List<usermodel>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var Data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in Data) {
        postlist.add(usermodel.fromJson(i));
      }
      return postlist;
    } else {
      throw Exception('Failed to load post');
    }
  }

  login(email, password) {
    getUserApi().then((value) {
      if (passwordController.text.isNotEmpty &&
          emailController.text.isNotEmpty) {
        for (int i = 0; i < 10; i++) {
          if (email == value[i].email && password == value[i].email) {
            print(_globalService.email.toString());
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Appbar_custom()));
          } else if (email == value[i].email && password != value[i].email) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter correct Password')));
          } else if (email != value[i].email && password == value[i].email) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter correct Email')));
          }
          // else {
          //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //       content: Text('Please enter correct email and password')));
          // }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please enter email and password')));
      }
    });

    // if usermodel.email == emailController.text.toString() && usermodel.password == passwordController.text.toString() {
    //   print('login success');
    // }
  }
  // Future<void> login(email, password) async {
  //   if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
  //     http.Response response = await post(
  //         Uri.parse('https://jsonplaceholder.typicode.com/users'),
  //         body: {
  //           'email': email,
  //           'password': email,
  //         });
  //     if (response.statusCode == 201) {
  //       var data = jsonDecode(response.body.toString());
  //       print(data.toString());
  //       // print(data['id']);
  //       // print('login success');
  //     } else {
  //       print('login failedd');
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('Please enter email and password'),
  //     ));
  //   }
  // }
}

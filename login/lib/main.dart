import 'package:flutter/material.dart';
import 'package:login/login.dart';

void main() => runApp(const Login());

class Home extends StatelessWidget {
  final String username;
  final String password;

  // receive data from the FirstScreen as a parameter
  Home({Key? key, required this.username, required this.password})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Row(
                  children: [
                    const Text(
                      'Username:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      username,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    const Text(
                      'Password:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      password,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ]));
  }
}

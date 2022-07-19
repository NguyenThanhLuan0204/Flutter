import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/login.dart';

void main() => runApp(const Login());

class Home extends StatelessWidget {
  final String username;
  final String password;

  // receive data from the FirstScreen as a parameter
  const Home({Key? key, required this.username, required this.password})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  const Text(
                    'Username:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    username,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Password:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    password,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Container(
                  child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    CupertinoPageRoute(builder: (context) => Login()),
                    (_) => false,
                  );
                },
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.red),
                ),
              )),
            ]));
  }
}

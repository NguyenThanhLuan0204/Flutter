import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/home.dart';
import 'package:login/register.dart';
import 'package:http/http.dart' as http;
import 'package:login/VerifyEmail.dart';

void main() => runApp(const Login());

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String jsonString;
  late String email;
  late String token;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/login.png'), fit: BoxFit.cover),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 0, top: 220),
                    child: const Text(
                      "Welcome",
                      style: TextStyle(color: Colors.white, fontSize: 33),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 80),
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Username or Email:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your Username or Email',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 30),
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Password:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                              labelText: 'Enter your Password',
                              // this button is used to toggle the password visibility
                              suffixIcon: IconButton(
                                  icon: Icon(_isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  })),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  IntrinsicWidth(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                            ),
                            onPressed: () async {
                              // Validate returns true if the form is valid, or false otherwise.
                              var headers = {
                                'Content-Type': 'application/json'
                              };
                              var request = http.Request(
                                  'POST',
                                  Uri.parse(
                                      'https://dakshow.vn/api/auth/login?locale=en'));
                              request.body = json.encode({
                                "usernameOrEmail":
                                    usernameController.text.toString(),
                                "password": passwordController.text.toString(),
                                "remember_me": true
                              });
                              request.headers.addAll(headers);

                              http.StreamedResponse response =
                                  await request.send();
                              jsonString =
                                  await response.stream.bytesToString();

                              print(_findAndCut(jsonString, '"code":', ','));
                              if (_findAndCut(jsonString, '"code":', ',') ==
                                  '400') {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Thông báo"),
                                        content: Text(
                                            'Thông tin đăng nhập sai, mới kiểm tra lại !'),
                                        actions: [
                                          FlatButton(
                                            child: const Text("Ok"),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  CupertinoPageRoute(
                                                      builder: (context) =>
                                                          const Login()));
                                            },
                                          )
                                        ],
                                      );
                                    });
                              }
                              ;
                              if (response.statusCode == 200) {
                                if (_findAndCut(jsonString, '"code":', ',') ==
                                    '200') {
                                  var jsoncode = jsonString.substring(8, 11);
                                  var activeStatus =
                                      _findAndCut(jsonString, '"active":', ',');

                                  email = _findAndCut(jsonString, '"email":"',
                                      '","username":"');

                                  int jsoncodenumber = int.parse(jsoncode);

                                  if (activeStatus == 'false') {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Thông báo"),
                                            content: const Text(
                                                'Chưa xác thực email, mời xác thực!'),
                                            actions: [
                                              TextButton(
                                                child:
                                                    const Text("Đi xác thực"),
                                                onPressed: () async {
                                                  var headers = {
                                                    'Authorization':
                                                        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxZDk5ZmZiNS04MGM2LTUzN2UtYTQxZS0xMzNlNzQ5MDlkODciLCJpYXQiOjE2NTgzODA3NDYsImV4cCI6MTY2MDk3Mjc0Nn0.DyrQsecYvkcrRl2yZ0Jhjgniomb0ztSW0DNhSGC3-XY',
                                                    'Content-Type':
                                                        'application/json'
                                                  };
                                                  var request = http.Request(
                                                      'POST',
                                                      Uri.parse(
                                                          'https://dakshow.vn/api/auth/active-account/send-code'));
                                                  request.body = json
                                                      .encode({"email": email});
                                                  request.headers
                                                      .addAll(headers);

                                                  http.StreamedResponse
                                                      response =
                                                      await request.send();

                                                  if (response.statusCode ==
                                                      200) {
                                                    String jsonStringSendCode =
                                                        await response.stream
                                                            .bytesToString();
                                                    token = _findAndCut(
                                                        jsonStringSendCode,
                                                        '"token":"',
                                                        '"');
                                                  } else {
                                                    print(
                                                        response.reasonPhrase);
                                                  }
                                                  print(token);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            VerifyEmail(
                                                          email: email,
                                                          token: token,
                                                        ),
                                                      ));
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  } else {
                                    _sendDataToSecondScreen(context);
                                  }
                                }
                              } else {
                                print(response.reasonPhrase);
                              }
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Don't Have an Account?",
                                style: TextStyle(fontFamily: 'Montserrat'),
                              ),
                              const SizedBox(width: 5.0),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Register()));
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendDataToSecondScreen(BuildContext context) {
    String usernameSend = usernameController.text;
    String passwordSend = passwordController.text;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(
            name: _findAndCut(jsonString, '"name":"', '",'),
            username: usernameSend,
            email: _findAndCut(jsonString, '"email":"', '",'),
            password: passwordSend,
          ),
        ));
  }

  String _findAndCut(str, start, end) {
    final startIndex = str.indexOf(start);
    final endIndex = str.indexOf(end, startIndex + start.length);
    return str.substring(
        startIndex + start.length, endIndex); // brown fox jumps
  }
}

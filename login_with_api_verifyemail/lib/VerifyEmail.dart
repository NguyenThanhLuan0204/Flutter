import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VerifyEmail extends StatelessWidget {
  final String email;
  final String token;

  // receive data from the FirstScreen as a parameter
  const VerifyEmail({
    Key? key,
    required this.email,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController codeController = TextEditingController();
    return Scaffold(
        appBar: AppBar(title: const Text('Verify Email')),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Row(
            children: [
              const Text(
                'email:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                email,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, top: 40),
            margin: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nhập mã xác thực',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextFormField(
                  controller: codeController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your Verify Code',
                  ),
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
                      var headers = {
                        'Authorization':
                            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIzNGFjMGNlOS01NTVkLTUwZWQtYmU3NS1iZmMwODJhMzEwMDQiLCJpYXQiOjE2NTgzODA1NTksImV4cCI6MTY2MDk3MjU1OX0.q7m7GuU27I-m1EMtM9X12Bs4XRaCKcyWw6SoW8DSLCg',
                        'Content-Type': 'application/json'
                      };
                      var request = http.Request(
                          'POST',
                          Uri.parse(
                              'https://dakshow.vn/api/auth/active-account'));
                      request.body = json.encode(
                          {"token": token, "code": codeController.text});
                      request.headers.addAll(headers);

                      http.StreamedResponse response = await request.send();

                      if (response.statusCode == 200) {
                        String jsonString =
                            await response.stream.bytesToString();
                        String code = _findAndCut(jsonString, '"code":', ',');
                        print(code);
                        print(token);
                        if (code == '200') {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Thông báo"),
                                  content: const Text('Xác thực thành công !'),
                                  actions: [
                                    TextButton(
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
                      } else {
                        print(response.reasonPhrase);
                      }
                    },
                    child: const Text(
                      'Verify',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ]),
          ),
        ]));
  }

  String _findAndCut(str, start, end) {
    final startIndex = str.indexOf(start);
    final endIndex = str.indexOf(end, startIndex + start.length);
    return str.substring(
        startIndex + start.length, endIndex); // brown fox jumps
  }
}

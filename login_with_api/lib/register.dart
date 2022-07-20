import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/login.dart';
import 'package:http/http.dart' as http;

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

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
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController accountTypeController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          // Overide the default Back button
          automaticallyImplyLeading: false,
          leadingWidth: 100,
          leading: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            },
            icon: const Icon(Icons.arrow_left_sharp),
            label: const Text('Back'),
            style: ElevatedButton.styleFrom(
                elevation: 0, primary: Colors.transparent),
          ),

          // other stuff
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 10, top: 40),
              margin: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Name:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, top: 40),
              margin: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Username:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your Username',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, top: 40),
              margin: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your Email',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, top: 40),
              margin: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Password:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, top: 40),
              margin: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Số Điện Thoại:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  TextFormField(
                    controller: phonenumberController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your phone number',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, top: 40),
              margin: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Loại tài khoản:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  TextFormField(
                    controller: accountTypeController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your Account Type',
                    ),
                  ),
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.only(left: 10, top: 40),
                margin: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ngày Sinh:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${selectedDate.toLocal()}".split(' ')[0],
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                            ])
                      ],
                    ),
                    RaisedButton(
                      padding: const EdgeInsets.only(left: 0, top: 0),
                      onPressed: () => _selectDate(context),
                      color: Colors.greenAccent, // Refer step 3
                      child: const Text(
                        'Select date',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
            Container(
              padding: const EdgeInsets.only(left: 10, top: 10),
              margin: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Giới Tính:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  TextFormField(
                    controller: sexController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your Sex',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 222, 222, 84))),
                onPressed: () async {
                  var headers = {
                    'Authorization':
                        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIzNGFjMGNlOS01NTVkLTUwZWQtYmU3NS1iZmMwODJhMzEwMDQiLCJpYXQiOjE2NTgyODQ5MzMsImV4cCI6MTY2MDg3NjkzM30.2C1LoHPR4UFoqop2gzvQmHDcDvQTJxFv5U0R8Itentc',
                    'Content-Type': 'application/json'
                  };
                  var request = http.Request(
                      'POST',
                      Uri.parse(
                          'https://dakshow.vn/api/auth/register?locale=vi'));
                  request.body = json.encode({
                    "name": nameController.text.toString(),
                    "username": usernameController.text.toString(),
                    "email": emailController.text.toString(),
                    "password": passwordController.text.toString(),
                    "phone_number": phonenumberController.text.toString(),
                    "account_type":
                        int.parse(accountTypeController.text.toString()),
                    "birthday": "${selectedDate.toLocal()}".split(' ')[0],
                    "sex": int.parse(sexController.text.toString())
                  });
                  request.headers.addAll(headers);

                  http.StreamedResponse response = await request.send();

                  if (response.statusCode == 200) {
                    String jsonString = await response.stream.bytesToString();
                    //print(jsonString);
                    print(jsonString);
                    var jsoncode = jsonString.substring(8, 11);
                    int jsoncodenumber = int.parse(jsoncode);
                    if (jsoncodenumber == 201) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Thông báo"),
                              content:
                                  const Text('Thông tin đăng kí thành công!'),
                              actions: [
                                FlatButton(
                                  child: const Text("Ok"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Login()));
                                  },
                                )
                              ],
                            );
                          });
                    } else {
                      String Errors =
                          _findAndCut(jsonString, '"field":"', '",');
                      print(Errors);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Thông báo"),
                              content: Text(
                                  'Thông tin đăng kí sai\nKiểm tra lại: $Errors !'),
                              actions: [
                                FlatButton(
                                  child: const Text("Ok"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
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
                  'Register',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            )
          ],
        ));
  }

  String _findAndCut(str, start, end) {
    final startIndex = str.indexOf(start);
    final endIndex = str.indexOf(end, startIndex + start.length);
    return str.substring(
        startIndex + start.length, endIndex); // brown fox jumps
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}

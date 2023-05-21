import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_tpm/homepage.dart';
import 'package:project_tpm/signup.dart';
import 'package:http/http.dart' as http;
import 'package:project_tpm/connection/conn.dart';


class loginpage extends StatefulWidget {
  const loginpage({Key? key, required this.title}) : super(key: key);

  final String title;



  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  @override
  String username = "";
  String password = "";
  bool isLoginSuccess = true;
  bool isUsername = true;
  bool isPassword = true;
  var Username_controller = TextEditingController();
  var Password_controller = TextEditingController();

  void _loginNow() async {
    try {
    var res = await http.post(
      Uri.parse(API.login),
      body:{
        "username" : Username_controller.text.trim(),
        "password" : Password_controller.text.trim(),
      },
    );
    if(res.statusCode == 200)
    {
      var resBodyOfLogin = jsonDecode(res.body);
      if (resBodyOfLogin['success'] == true) {
        Fluttertoast.showToast(msg: "Login success!");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) {
            return Homepage();
        }
        )
        );
      } else {
        Fluttertoast.showToast(msg: "Login failed, please write the correct username or password...");
      }
    }
    }catch(e){
      print("error = " + e.toString());
    }
    }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 100,),
            FlutterLogo(
              size: 80,
            ),
            SizedBox(
              height: 150,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: TextFormField(
                onChanged: (value) {
                  username = value;
                }, decoration: InputDecoration(hintText: 'Username',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: TextFormField(
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: ElevatedButton(style: ElevatedButton.styleFrom(
                  primary: (isLoginSuccess) ? Colors.green[800] : Colors.red,
                  shape: StadiumBorder()
              ),
                onPressed: () {
                  Username_controller.text = username;
                  Password_controller.text = password;
                  print(Username_controller.text);
                  if (Username_controller.text != "" &&
                      Password_controller.text != "" ) {
                      _loginNow();
                  } else {
                    SnackBar snackBar = SnackBar(
                      content: Text("Tidak Boleh Ada Yang Kosong"),
                      backgroundColor: Colors.redAccent,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }, child: Text('LOGIN'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context){
                          return signup();
                        })
                    );
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }
}





import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:project_tpm/connection/conn.dart';
import 'package:project_tpm/login.dart';
import 'package:project_tpm/user/users.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String username = "";
  String password = "";
  String confirmPassword = "";

  @override


  void _onRegister() async {
    User userModel = User(
        1,
        usernameController.text.trim(),
        passwordController.text.trim(),
    );
    try
        {
          var res = await http.post(
            Uri.parse(API.signUp),
            body : userModel.toJson(),
          );
          if(res.statusCode == 200){
            var resBodyOfSignUp = jsonDecode(res.body);
            if(resBodyOfSignUp['success'] == true){
              Fluttertoast.showToast(msg: "Sign up success!");
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return loginpage(title: 'Login Page');
                  }
                  )
              );
            }else{
              Fluttertoast.showToast(msg: "Sign up failed...");
            }
          }
        }
        catch(e){
          print(e.toString());
          Fluttertoast.showToast(msg: e.toString());
        }

  }

  @override
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
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: TextFormField(
                onChanged: (value) {
                  confirmPassword = value;
                },
                obscureText: true,
                decoration: InputDecoration(hintText: 'Confirm Password',
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.green[800],
                  shape: StadiumBorder()
                ),
                onPressed: () {
                  usernameController.text = username;
                  passwordController.text = password;
                  confirmPasswordController.text = confirmPassword;
                  if (usernameController.text != "" &&
                      passwordController.text != "" &&
                      confirmPasswordController.text != "" ) {
                    if(passwordController.text == confirmPasswordController.text){
                      _onRegister();
                    }else{
                      SnackBar snackBar = SnackBar(
                        content: Text("Password harus sama!"),
                        backgroundColor: Colors.redAccent,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } else {
                    SnackBar snackBar = SnackBar(
                      content: Text("Tidak Boleh Ada Yang Kosong"),
                      backgroundColor: Colors.redAccent,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }, child: Text('Register'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                const Text('Have an account?'),
                TextButton(
                  child: const Text(
                    'Log in',
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context){
                          return loginpage(title: 'Login Page',);
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

import 'package:flutter/material.dart';
import 'package:okkpd_mobile/pages/login/loginWidget.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body:LoginWidget()
    );
  }
}

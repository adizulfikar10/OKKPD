import 'package:flutter/material.dart';
import 'package:okkpd_mobile/pages/user/userWidget.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: UserBody()
    );
  }
}

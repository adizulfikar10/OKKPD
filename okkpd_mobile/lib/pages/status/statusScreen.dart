import 'package:flutter/material.dart';
import 'package:okkpd_mobile/pages/status/statusTracking.dart';

class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:  StatusTracking()
        ),
    );
  }
}

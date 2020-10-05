import 'package:flutter/material.dart';
import 'package:okkpd_mobile/pages/media/mediaWidget.dart';

class Mediascreen extends StatefulWidget {
  @override
  _Mediascreen createState() => _Mediascreen();
}

class _Mediascreen extends State<Mediascreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: MediaWidget()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:okkpd_mobile/pages/profilUsaha/profilUsahaWidget.dart';

class ProfilUsahaScreen extends StatefulWidget {
  @override
  _ProfilUsahaScreenState createState() => _ProfilUsahaScreenState();
}

class _ProfilUsahaScreenState extends State<ProfilUsahaScreen> {
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: Colors.white,
      body: ProfilUsahaBody()
    );
  }
}

import 'package:flutter/material.dart';
import 'package:okkpd_mobile/pages/dashboard/beritaWidget.dart';

import '../../tools/GlobalFunction.dart';

class BeritaAllScreen extends StatefulWidget {
  @override
  _BeritaAllScreenState createState() => _BeritaAllScreenState();
}

class _BeritaAllScreenState extends State<BeritaAllScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FunctionDart.setAppBar("Berita Terbaru"),
      body: BeritaWidget("all"),
    );
  }
}

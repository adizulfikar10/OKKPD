import 'package:flutter/material.dart';
import 'package:okkpd_mobile/model/repository/SharedPrefRepo.dart';
import 'package:okkpd_mobile/pages/layanan/detailKomoditasScreen.dart';
import 'package:okkpd_mobile/pages/layanan/infoUsahaScreen.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../tools/GlobalFunction.dart';

class PrimaduaScreen extends StatefulWidget {
  @override
  _PrimaduaScreen createState() => _PrimaduaScreen();
}

class _PrimaduaScreen extends State<PrimaduaScreen> {
  ProgressDialog pr;

  List getKomoditas = [];
  List komoditas = [];
  String idUser = "";

  @override
  void initState() {
    super.initState();
    getIdUser();

  }

  void getIdUser() async{
    String id = await SharedPrefRepo().getIdUser();
    setState(() {
      idUser = id;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: FunctionDart.setAppBar("Pendaftaran PRIMA 2"),
      body: Container(
          child: Column(
        children: <Widget>[
          InfoUsahaScreen(idUser),
          Expanded(
            child: DetailKomoditasScreen("prima_2"),
          )
        ],
      )),
    );
  }
}

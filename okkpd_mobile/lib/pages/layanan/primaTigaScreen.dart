import 'package:flutter/material.dart';
import 'package:okkpd_mobile/model/repository/SharedPrefRepo.dart';
import 'package:okkpd_mobile/pages/layanan/detailKomoditasScreen.dart';
import 'package:okkpd_mobile/pages/layanan/infoUsahaScreen.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../tools/GlobalFunction.dart';

class PrimatigaScreen extends StatefulWidget {
  @override
  _PrimatigaScreen createState() => _PrimatigaScreen();
}

class _PrimatigaScreen extends State<PrimatigaScreen> {
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
      appBar: FunctionDart.setAppBar("Pendaftaran PRIMA 3"),
      body: Container(
          child: Column(
        children: <Widget>[
          InfoUsahaScreen(idUser),
          Expanded(
            child: DetailKomoditasScreen("prima_3"),
          )
        ],
      )),
    );
  }
}

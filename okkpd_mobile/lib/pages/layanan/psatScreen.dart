import 'package:flutter/material.dart';
import 'package:okkpd_mobile/model/repository/SharedPrefRepo.dart';
import 'package:okkpd_mobile/pages/layanan/detailPsatScreen.dart';
import 'package:okkpd_mobile/pages/layanan/infoUsahaScreen.dart';

import '../../tools/GlobalFunction.dart';

class Psatscreen extends StatefulWidget {
  @override
  _Psatscreen createState() => _Psatscreen();
}

class _Psatscreen extends State<Psatscreen> {

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
      appBar: FunctionDart.setAppBar("Pendaftaran PSAT"),
      body: Container(
        child: Column(
          children: <Widget>[
            InfoUsahaScreen(idUser),
            Expanded(
              child: DetailPsatScreen("Psat"),
            )
          ],
        ),
      ),
    );
  }
}

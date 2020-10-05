import 'package:flutter/material.dart';
import 'package:okkpd_mobile/model/repository/SharedPrefRepo.dart';
import 'package:okkpd_mobile/pages/layanan/detailHcScreen.dart';
import 'package:okkpd_mobile/pages/layanan/infoUsahaScreen.dart';

import '../../tools/GlobalFunction.dart';

class Hcscreen extends StatefulWidget {
  @override
  _Hcscreen createState() => _Hcscreen();
}

class _Hcscreen extends State<Hcscreen> {

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
      appBar: FunctionDart.setAppBar("Pendaftaran HC"),
      body: Container(
        child: Column(
          children: <Widget>[
            InfoUsahaScreen(idUser),
            Expanded(
              child: DetailHcScreen("HC"),
            )
          ],
        ),
      ),
    );
  }
}

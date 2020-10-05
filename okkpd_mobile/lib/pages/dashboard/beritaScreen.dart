import 'package:flutter/material.dart';
import 'package:okkpd_mobile/constants/key.dart';
import 'package:okkpd_mobile/model/beritaModel.dart';
import 'package:okkpd_mobile/model/repository/beritaRepo.dart';
import 'package:okkpd_mobile/tools/CustomWidget.dart';

import '../../tools/GlobalFunction.dart';

class BeritaScreen extends StatefulWidget {
  String idBerita;
  BeritaScreen(this.idBerita);

  @override
  _BeritaScreen createState() => _BeritaScreen(idBerita);
}

class _BeritaScreen extends State<BeritaScreen> {
  String idBerita;
  _BeritaScreen(this.idBerita);
  BeritaModel berita = new BeritaModel("", "", "", "", "", "", "");
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    getBerita();
  }

  void getBerita() async {
    BeritaModel beritas = await BeritaRepo().viewBerita(idBerita);
    setState(() {
      berita = beritas;
      isLoading = false;
    });
  }

  Widget viewBerita() {
    if (isLoading) {
      return CustomWidget().loadingWidget();
    }
    return CustomScrollView(
        scrollDirection: Axis.vertical,
        shrinkWrap: false,
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              padding: EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16.0, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    berita.judulBerita,
                    style: Keys().mediumBoldFontSize,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      berita.tanggalBuat,
                      style: Keys().smallFontSize,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Divider(
                    height: 1,
                  ),
                  SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      berita.isiBerita,
                      style: Keys().normalFontSize,
                      strutStyle: StrutStyle(
                        fontFamily: 'Roboto',
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FunctionDart.setAppBar("Berita"),
      body: viewBerita(),
    );
  }
}

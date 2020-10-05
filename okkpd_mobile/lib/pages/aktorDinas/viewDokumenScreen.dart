import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:okkpd_mobile/model/dokumenInspeksiModel.dart';
import 'package:okkpd_mobile/model/repository/layananRepo.dart';
import 'package:okkpd_mobile/tools/CustomWidget.dart';

class ViewDokumenScreen extends StatefulWidget {
  final String idGambar;
  final String idLayanan;
  ViewDokumenScreen(this.idLayanan, this.idGambar);
  @override
  _ViewDokumenScreen createState() =>
      _ViewDokumenScreen(this.idLayanan, this.idGambar);
}

class _ViewDokumenScreen extends State<ViewDokumenScreen> {
  final String idGambar;
  final String idLayanan;
  _ViewDokumenScreen(this.idLayanan, this.idGambar);

  DokumenInspeksiModel dokumen;
  String title = "eldp|okkpd";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var data = await LayananRepo().getGambar(idLayanan, idGambar);
    setState(() {
      isLoading = false;
      dokumen = data;
      title = dokumen.keterangan;
    });
  }

  Widget gambarDokumen() {
    if (isLoading) {
      return CustomWidget().loadingWidget();
    } else {
      var gambar = base64.decode(dokumen.gambar);
      return Container(
        child: Image.memory(gambar),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(child: gambarDokumen()),
    );
  }
}

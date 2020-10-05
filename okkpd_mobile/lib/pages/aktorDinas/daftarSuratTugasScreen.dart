import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:okkpd_mobile/constants/key.dart';
import 'package:okkpd_mobile/model/layananModel.dart';
import 'package:okkpd_mobile/model/repository/layananRepo.dart';
import 'package:okkpd_mobile/tools/CustomWidget.dart';

import '../../tools/GlobalFunction.dart';

class DaftarSuratTugasScreen extends StatefulWidget {
  @override
  _DaftarSuratTugasScreenState createState() => _DaftarSuratTugasScreenState();
}

class _DaftarSuratTugasScreenState extends State<DaftarSuratTugasScreen> {
  List listLayanan = [];
  final List<LayananModel> layanans = [];

  var isLoading = true;
  var haveData = true;

  @override
  void initState() {
    super.initState();
    getLayananDitolak();
  }

  void getLayananDitolak() async {
    listLayanan = await LayananRepo().getLayananDitolak();
    setState(() {
      layanans.clear();
      if (listLayanan != null) {
        haveData = true;
        for (var datas in listLayanan) {
          layanans.add(datas);
        }
      } else {
        haveData = false;
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FunctionDart.setAppBar("Surat Tugas"),
      body: Column(
        children: <Widget>[
          Expanded(child: _buildSuggestions()),
        ],
      ),
    );
  }

  _buildSuggestions() {
    if (isLoading) {
      return CustomWidget().loadingWidget();
    } else {
      if (haveData) {
        return ListView.builder(
            itemCount: layanans.length,
            itemBuilder: (context, i) {
              return _buildRow(layanans[i], i);
            });
      } else {
        return Center(
          child: Text("Tidak ada data yang ditampilkan"),
        );
      }
    }
  }

  _buildRow(LayananModel layanan, int i) {
    return ListTile(
        title: Card(
            elevation: 2,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              layanan.namaLayanan,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              "Nama Perusahaan : ${layanan.namaUsaha}",
                              style: Keys().normalFontSize,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              "Kode Pendaftaran : ${layanan.kodePendaftaran}",
                              style: Keys().normalFontSize,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              "Alasan Penolakan: ${layanan.alasanPenolakan}",
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 16.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}

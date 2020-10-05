import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:okkpd_mobile/constants/key.dart';
import 'package:okkpd_mobile/model/layananModel.dart';
import 'package:okkpd_mobile/model/repository/SharedPrefRepo.dart';
import 'package:okkpd_mobile/model/repository/layananRepo.dart';
import 'package:okkpd_mobile/pages/aktorDinas/daftarDokumenPelaksanaScreen.dart';
import 'package:okkpd_mobile/pages/aktorDinas/detailUsahaScreen.dart';
import 'package:okkpd_mobile/pages/aktorDinas/terimaLayananScreen.dart';
import 'package:okkpd_mobile/tools/CustomWidget.dart';

import '../../tools/GlobalFunction.dart';

class LayananDiterimaWidget extends StatefulWidget {
  @override
  _LayananDiterimaWidgetState createState() => _LayananDiterimaWidgetState();
}

class _LayananDiterimaWidgetState extends State<LayananDiterimaWidget> {
  List listLayanan = [];
  final List<LayananModel> layanans = [];

  var isLoading = true;
  var haveData = true;
  var myRole = "";
  var titleScreen = "eldp";

  @override
  void initState() {
    super.initState();
    getLayananDiterima();
    getRole();
  }

  void getRole() async {
    String role = await SharedPrefRepo().getRole();
    setState(() {
      if (role == 'm_adm') {
        titleScreen = "Penilaian Dokumen";
      } else if (role == 'm_teknis') {
        titleScreen = "Permohonan Inspeksi";
      } else {
        titleScreen = "Surat Tugas";
      }
      myRole = role;
    });
  }

  void getLayananDiterima() async {
    listLayanan = await LayananRepo().getLayananDiterima();
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
      appBar: FunctionDart.setAppBar(titleScreen),
      body: Column(
        children: <Widget>[
          Expanded(child: _buildSuggestions()),
        ],
      ),
    );
  }

  Widget buttonUpload(LayananModel layanan) {
    if (myRole == 'pelaksana') {
      return Container(
        width: double.infinity,
        child: Material(
          child: MaterialButton(
            height: 42.0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailUsahaScreen(layanan)),
              );
            },
            color: Colors.lightBlueAccent,
            child: Text('Lihat Detail', style: TextStyle(color: Colors.white)),
          ),
        ),
      );
    } else {
      return Text("");
    }
  }

  Widget buttonUser(LayananModel layanan) {
    if (myRole == 'm_adm') {
      return Row(
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              child: Material(
                child: MaterialButton(
                  height: 42.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailUsahaScreen(layanan)),
                    );
                  },
                  color: Colors.lightBlueAccent,
                  child: Text('Informasi Usaha',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: Material(
                child: MaterialButton(
                  height: 42.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TerimaLayananScreen(layanan)),
                    );
                  },
                  color: Colors.lightBlueAccent,
                  child: Text('Detail Dokumen',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          )
        ],
      );
    } else if (myRole == 'pelaksana') {
      return Row(
        children: <Widget>[
          Expanded(
            child: Material(
              child: MaterialButton(
                height: 42.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailUsahaScreen(layanan)),
                  );
                },
                color: Colors.lightBlueAccent,
                child: Text('Informasi Usaha',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Material(
              child: MaterialButton(
                height: 42.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DaftarDokumenPelaksanaScreen(layanan)),
                  );
                },
                color: Colors.lightBlueAccent,
                child: Text('Dokumen Inspeksi',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container(
        width: double.infinity,
        child: Material(
          child: MaterialButton(
            height: 42.0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailUsahaScreen(layanan)),
              );
            },
            color: Colors.lightBlueAccent,
            child:
                Text('Informasi Usaha', style: TextStyle(color: Colors.white)),
          ),
        ),
      );
    }
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
                              "Tanggal Pengajuan : ${layanan.tanggalBuat}",
                              style: Keys().normalFontSize,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              "Kode Pendaftaran : ${layanan.kodePendaftaran}",
                              style: Keys().normalFontSize,
                            ),
                            SizedBox(height: 16.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                  buttonUser(layanan),
                  SizedBox(
                    width: 16,
                  ),
                ],
              ),
            )));
  }
}

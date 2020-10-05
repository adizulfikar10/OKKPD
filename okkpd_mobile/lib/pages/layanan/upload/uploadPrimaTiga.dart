import 'package:flutter/material.dart';
import 'package:okkpd_mobile/model/mediaModel.dart';
import 'package:okkpd_mobile/model/repository/layananRepo.dart';
import 'package:okkpd_mobile/model/repository/mediaRepo.dart';
import 'package:okkpd_mobile/pages/layanan/upload/tambahDokumenScreen.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';

class UploadPrimaTiga extends StatefulWidget {
  final idLayanan;
  const UploadPrimaTiga(this.idLayanan);
  @override
  _UploadPrimaTigaState createState() => _UploadPrimaTigaState(idLayanan);
}

class _UploadPrimaTigaState extends State<UploadPrimaTiga> {
  final idLayanan;
  _UploadPrimaTigaState(this.idLayanan);

  List listLayanan = [];
  bool isComplete = true;
  final List<MediaModel> mediaHeader = [];
  final List<MediaModel> mediaDetail = [];
  final List<String> statusLayanan = [];

  @override
  void initState() {
    super.initState();
    getMediaHeader(idLayanan, 'header');
    getMediaDetail(idLayanan, 'detail');
  }

  void getMediaHeader(String layanan, String status) async {
    listLayanan = await MediaRepo().getMedia(layanan, status);
    setState(() {
      mediaHeader.clear();
      if (listLayanan != null) {
        for (var datas in listLayanan) {
          mediaHeader.add(datas);
        }
      }
    });
  }

  void getMediaDetail(String layanan, String status) async {
    listLayanan = await MediaRepo().getMedia(layanan, status);
    setState(() {
      mediaDetail.clear();
      if (listLayanan != null) {
        for (var datas in listLayanan) {
          mediaDetail.add(datas);
        }
      }
    });
  }

  void simpanDokumen() async {
    if (await LayananRepo().simpanLayanan(idLayanan) == true) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FunctionDart.setAppBar("Unggah Dokumen"),
      body: Column(
        children: <Widget>[
          Expanded(child: _buildSuggestions()),
          Container(
              padding:
                  EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8),
              child: new SizedBox(
                width: double.infinity,
                child: new RaisedButton(
                  child: Text("Simpan"),
                  onPressed: () {
                    setState(() {
                      isComplete = getDokumen();
                    });
                    if (isComplete) {
                      simpanDokumen();
                    } else {
                      FunctionDart().setToast("Dokumen belum lengkap");
                    }
                  },
                ),
              ))
        ],
      ),
    );
  }

  _buildSuggestions() {
    return ListView.builder(
        itemCount: mediaHeader.length,
        itemBuilder: (context, i) {
          return _buildRow(mediaHeader[i], i);
        });
  }

  bool getDokumen() {
    for (int i = 0; i < mediaHeader.length; i++) {
      var count = 0;
      for (int a = 0; a < mediaDetail.length; a++) {
        if (mediaHeader[i].kodeDokumen == mediaDetail[a].kodeDokumen) {
          count++;
        }
      }
      if (count == 0) {
        return false;
      }
    }
    return true;
  }

  _buildMedia(String kodeDokumen) {
    double tinggi = 0;
    List listMedia = [];
    for (int i = 0; i < mediaDetail.length; i++) {
      if (mediaDetail[i].kodeDokumen == kodeDokumen) {
        listMedia.add(mediaDetail[i]);
        tinggi += 28.0;
      }
    }

    if (listMedia.length == 0) {
      isComplete = false;
    }

    return SizedBox(
      height: tinggi,
      // width: 350,
      child: new ListView.builder(
        physics: new NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: listMedia.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Padding(
              padding: EdgeInsets.only(top: 4),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text("${index + 1}"),
                    width: 26,
                  ),
                  Text(listMedia[index].namaMedia.length >= 25
                      ? listMedia[index].namaMedia.substring(0, 25) + '...'
                      : listMedia[index].namaMedia)
                ],
              ));
        },
      ),
    );
  }

  _uploadGambar(MediaModel media) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TambahDokumenScreen(media.kodeDokumen)),
    );

    if (result == true) {
      getMediaDetail(idLayanan, 'detail');
      setState(() {
        isComplete = getDokumen();
      });
    }
  }

  _buildRow(MediaModel media, int i) {
    return ListTile(
        title: Column(
      children: <Widget>[
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Container(
                  width: 310,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        media.namaDokumen,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      SizedBox(height: 16.0),
                      Expanded(flex: 0, child: _buildMedia(media.kodeDokumen)),
                      RaisedButton(
                        child: Text("Tambah Dokumen"),
                        onPressed: () {
                          _uploadGambar(media);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:okkpd_mobile/constants/key.dart';
import 'package:okkpd_mobile/model/layananModel.dart';
import 'package:okkpd_mobile/model/masterLayananModel.dart';
import 'package:okkpd_mobile/model/repository/layananRepo.dart';
import 'package:okkpd_mobile/pages/layanan/upload/uploadPrimaTiga.dart';
import 'package:okkpd_mobile/tools/CustomWidget.dart';

class StatusTracking extends StatefulWidget {
  @override
  _StatusTrackingState createState() => _StatusTrackingState();
}

class _StatusTrackingState extends State<StatusTracking> {
  List listLayanan = [];
  final List<LayananModel> layanans = [];
  final List<MasterLayananModel> masterLayanan = [];
  final List<String> statusLayanan = [];

  String idLayanan;
  String status;

  var isLoading = true;
  var haveData = true;

  @override
  void initState() {
    super.initState();

    getLayanan('%', '%');

    masterLayanan.add(MasterLayananModel("%", "Semua Layanan", "",""));
    masterLayanan.add(MasterLayananModel("prima_3", "Prima 3", "",""));
    masterLayanan.add(MasterLayananModel("prima_2", "Prima 2", "",""));
    masterLayanan.add(MasterLayananModel("psat", "PSAT", "",""));
    masterLayanan.add(MasterLayananModel("kemas", "Rumah Kemas", "",""));
    masterLayanan.add(MasterLayananModel("hc", "Health Certificate", "",""));

    statusLayanan.add("Semua");
    statusLayanan.add("Lengkapi Dokumen");
    statusLayanan.add("Menunggu");
    statusLayanan.add("Diterima");
    statusLayanan.add("Ditolak");
  }

  void getLayanan(String layanan, String status) async {
    listLayanan = await LayananRepo().getLayanan(layanan, status);
    setState(() {
      layanans.clear();
      if (listLayanan != null) {
        haveData = true;
        for (var datas in listLayanan) {
          layanans.add(datas);
        }
      }else{
        haveData = false;
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                height: 86.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      child: Text("Layanan", style: Keys().smallFontSize),
                      padding: EdgeInsets.only(left: 16, top: 16),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16, bottom: 8, top: 4, right: 16),
                      child: DropdownButton(
                        isDense: true,
                        underline: Container(
                          color: Colors.red,
                        ),
                        hint: new Text('Semua Layanan'),
                        style: TextStyle(fontSize: 14.0, color: Colors.black),
                        isExpanded: true,
                        items: masterLayanan.map((value) {
                          return new DropdownMenuItem(
                            child: new Text(value.namaLayanan),
                            value: value.kodeLayanan.toString(),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            idLayanan = value;
                          });
                          getLayanan(idLayanan, status);
                        },
                        value: idLayanan,
                      ),
                    ),
                    Divider(
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 1,
              height: 75,
              color: Colors.black12,
            ),
            Expanded(
              child: Container(
                height: 86.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      child: Text("Status", style: Keys().smallFontSize),
                      padding: EdgeInsets.only(left: 16, top: 16),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16, bottom: 8, top: 4, right: 16),
                      child: DropdownButton(
                        isDense: true,
                        underline: Container(
                          color: Colors.red,
                        ),
                        hint: new Text('Semua'),
                        style: TextStyle(fontSize: 14.0, color: Colors.black),
                        isExpanded: true,
                        items: statusLayanan.map((value) {
                          return new DropdownMenuItem(
                            child: new Text(value),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            status = value;
                          });

                          getLayanan(idLayanan, status);
                        },
                        value: status,
                      ),
                    ),
                    Divider(
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Expanded(child: _buildSuggestions()),
      ],
    );
  }

  _buildSuggestions() {
    if(isLoading){
     return CustomWidget().loadingWidget();
    }else {
      if(haveData) {
        return ListView.builder(
            itemCount: layanans.length,
            itemBuilder: (context, i) {
              return _buildRow(layanans[i], i);
            });
      }else{
        return Center(child: Text("Tidak ada data yang ditampilkan"),);
      }
    }
  }

  Widget getWidget(String stat) {
    if (stat == "1") {
      return new Container(
        width: 20,
        height: 50,
        decoration: new BoxDecoration(
          color: Colors.green,
          borderRadius: new BorderRadius.all(new Radius.circular(100.0)),
        ),
        child: IconButton(
          icon: new Icon(Icons.check_circle_outline),
          color: Colors.white,
          onPressed: () {},
        ),
      );
    } else if (stat == "0") {
      return new Container(
        width: 20,
        height: 50,
        decoration: new BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: new BorderRadius.all(new Radius.circular(100.0)),
        ),
        child: IconButton(
          icon: new Icon(Icons.alarm),
          color: Colors.white,
          onPressed: () {},
        ),
      );
    } else {
      return new Container(
        width: 20,
        height: 50,
        decoration: new BoxDecoration(
          color: Colors.redAccent,
          borderRadius: new BorderRadius.all(new Radius.circular(100.0)),
        ),
        child: IconButton(
          icon: new Icon(Icons.close),
          color: Colors.white,
          onPressed: () {},
        ),
      );
    }
  }

  void selectLayanan(LayananModel layananModel) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => UploadPrimaTiga(layananModel.uid)),
    );
    if (result == true) {
      setState(() {
        getLayanan('%', '0');
      });
    }
  }

  Widget buttonUpload(LayananModel layananModel) {
    if (layananModel.kodePendaftaran == null ||
        layananModel.kodePendaftaran == '') {
      return new RaisedButton(
        onPressed: () {
          selectLayanan(layananModel);
        },
        child: Text("Unggah Dokumen"),
      );
    } else if (layananModel.status == '2') {
      return new Text("Alasan Penolakan: ${layananModel.alasanPenolakan}",
          style: Keys().normalFontSize);
    } else {
      return new Text("Kode Pendaftaran: ${layananModel.kodePendaftaran}",
          style: Keys().normalFontSize);
    }
  }

  _buildRow(LayananModel layanan, int i) {
    return ListTile(
        title: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              child: getWidget(layanan.status),
              width: 50,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    layanan.namaLayanan,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Tanggal Pengajuan : ${layanan.tanggalBuat}",
                    style: Keys().normalFontSize,
                  ),
                  SizedBox(height: 8.0),
                  buttonUpload(layanan),
                  SizedBox(height: 16.0),
                ],
              ),
            )
          ],
        ),
        Divider(),
      ],
    ));
  }
}

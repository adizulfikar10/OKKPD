import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:okkpd_mobile/constants/key.dart';
import 'package:okkpd_mobile/model/notifikasiModel.dart';
import 'package:okkpd_mobile/model/repository/userRepo.dart';
import 'package:okkpd_mobile/tools/CustomWidget.dart';

import '../../tools/GlobalFunction.dart';

class NotifikasiScreen extends StatefulWidget {
  @override
  _NotifikasiScreenState createState() => _NotifikasiScreenState();
}

class _NotifikasiScreenState extends State<NotifikasiScreen> {
  List listNotifikasi = [];

  var isLoading = true;
  var haveData = true;

  @override
  void initState() {
    super.initState();
    getNotifikasi();
  }

  void getNotifikasi() async {
    var list = await UserRepo().getNotifikasi();
    // var readAll = await UserRepo().readAllNotif();
    setState(() {
      listNotifikasi.clear();
      if (list != null) {
        haveData = true;
        for (var datas in list) {
          listNotifikasi.add(datas);
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
      appBar: FunctionDart.setAppBar("Notifikasi"),
      body: _buildSuggestions(),
    );
  }

  _buildSuggestions() {
    if (isLoading) {
      return CustomWidget().loadingWidget();
    } else {
      if (haveData) {
        return ListView.builder(
            itemCount: listNotifikasi.length,
            itemBuilder: (context, i) {
              return _buildRow(listNotifikasi[i], i);
            });
      } else {
        return Center(
          child: Text("Tidak ada data yang ditampilkan"),
        );
      }
    }
  }

  BoxDecoration setDecoration(String isRead) {
    if (isRead == "1") {
      return BoxDecoration(
          color: Colors.transparent,
          border: new Border.all(
              color: Color.fromRGBO(200, 200, 200, 100), width: 0.0),
          borderRadius: new BorderRadius.circular(4.0));
    } else {
      return BoxDecoration(
          color: Colors.amberAccent,
          border: new Border.all(
              color: Color.fromRGBO(200, 200, 200, 100), width: 0.0),
          borderRadius: new BorderRadius.circular(4.0));
    }
  }

  _buildRow(NotifikasiModel notif, int i) {
    return Container(
      decoration: setDecoration(notif.isRead),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            notif.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            "Tanggal : ${notif.tanggal}",
            style: Keys().smallFontSize,
          ),
          SizedBox(height: 16.0),
          Text(
            "${notif.body}",
            style: Keys().normalFontSize,
          ),
        ],
      ),
    );
  }
}

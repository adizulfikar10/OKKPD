import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:okkpd_mobile/constants/key.dart';
import 'package:okkpd_mobile/model/repository/layananRepo.dart';
import 'package:okkpd_mobile/model/trackLayananModel.dart';

import '../../tools/GlobalFunction.dart';

class TrackingStatusScreen extends StatefulWidget {
  TrackingStatusScreen(this.kode);
  final String kode;

  @override
  _TrackingStatusScreen createState() => _TrackingStatusScreen(kode);
}

void _portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class _TrackingStatusScreen extends State<TrackingStatusScreen> {
  final List<TrackLayananModel> layanan = [];
  _TrackingStatusScreen(this.kode);
  final String kode;

  void getLayanan() async {
    List<TrackLayananModel> data = await LayananRepo().trackLayanan(kode);
    setState(() {
      if (data != null) {
        for (int i = 0; i < data.length; i++) {
          if (data[i].tanggalProses != null) {
            layanan.add(data[i]);
          }
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getLayanan();
  }

  _buildSuggestions() {
    if (layanan.length != null && layanan.length > 0) {
      return ListView.builder(
          itemCount: layanan.length,
          itemBuilder: (context, i) {
            return _buildRow(layanan[i], i);
          });
    } else {
      return Container(
          padding: EdgeInsets.all(16), child: Text("Layanan tidak ditemukan"));
    }
  }

  _buildRow(TrackLayananModel layananModel, int i) {
    return ListTile(
      title: Card(
        margin: EdgeInsets.only(top: 8),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                layananModel.namaStatus,
                style: Keys().normalFontSize,
              ),
              Text(layananModel.tanggalProses),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: FunctionDart.setAppBar("Tracking Layanan"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: _buildSuggestions(),
            ),
          ],
        ),
      ),
    );
  }
}

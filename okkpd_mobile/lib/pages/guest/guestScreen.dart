import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:okkpd_mobile/model/repository/layananRepo.dart';
import 'package:okkpd_mobile/model/trackSertifikatModel.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';

class GuestScreen extends StatefulWidget {
  @override
  _GuestScreen createState() => _GuestScreen();
}

void _portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class _GuestScreen extends State<GuestScreen> {
  String _barcodeScanRes = "";
  String noSertikat = "";
  String tanggalKaduluarsa = "";
  String statusAktif = "";
  String namaProduk = "";
  String keterangan = "";
  String namaUsaha = "";

  Future scanBarcodeNormal() async {
    _barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.QR);

    TrackSertifikatModel result =
        await LayananRepo().trackSertifikat(_barcodeScanRes);

    setState(() {
      noSertikat = result.nomorSertifikat;
      tanggalKaduluarsa = result.tanggalAkhir;
      namaProduk = result.namaProduk;
      keterangan = "(${result.keterangan})";
      namaUsaha = result.namaUsaha;
      statusAktif = result.statusAktif;
    });
  }

  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          Container(
              color: Color.fromRGBO(239, 239, 239, 100),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text("Status",
                          style: new TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(statusAktif,
                          style: new TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Table(
                      border: TableBorder(
                        horizontalInside: BorderSide(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 0.0,
                        ),
                        verticalInside: BorderSide(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 0.0,
                        ),
                      ),
                      children: [
                        _buildTableRow("No Sertifikat, $noSertikat"),
                        _buildTableRow("Pelaku Usaha, $namaUsaha"),
                        _buildTableRow("Nama Produk, $namaProduk $keterangan"),
                        _buildTableRow(
                            "Tanggal Kaduluarsa, $tanggalKaduluarsa"),
                      ],
                    ),
                  ),
                ],
              )),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 25.0),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Material(
              child: FunctionDart.customButton(
                  context, scanBarcodeNormal, "Scan Sertifikat"),
              // child: MaterialButton(
              //   minWidth: 200.0,
              //   height: 42.0,
              //   onPressed: scanBarcodeNormal,
              //   color: Colors.lightBlueAccent,
              //   child: Text('Scan Sertifikat',
              //       style: TextStyle(color: Colors.white, fontSize: 20.0)),
              // ),
            ),
          ),
        ],
      ),
    ));
  }

  TableRow _buildTableRow(String listOfNames) {
    return TableRow(
      children: listOfNames.split(',').map((name) {
        return Container(
          alignment: Alignment.topLeft,
          child: Text(name, style: TextStyle(fontSize: 14.0)),
          padding: EdgeInsets.all(16.0),
        );
      }).toList(),
    );
  }
}

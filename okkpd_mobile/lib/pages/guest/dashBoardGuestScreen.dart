import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:okkpd_mobile/pages/dashboard/beritaWidget.dart';
import 'package:okkpd_mobile/pages/guest/trackingStatusScreen.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';

class DashboarGuestScreen extends StatefulWidget {
  @override
  _DashboarGuestScreen createState() => _DashboarGuestScreen();
}

class _DashboarGuestScreen extends State<DashboarGuestScreen> {
  var _kodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final kodeRegistrasi = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 200,
              height: 100,
              alignment: AlignmentDirectional(2.0, 0.0),
              child: Image(image: AssetImage('assets/logo.png'))),
          Container(
            alignment: Alignment.center,
            child: new Text(
              'Tracking Layanan Anda',
              style: new TextStyle(color: Colors.black, fontSize: 20.0),
            ),
          ),
          new Padding(padding: EdgeInsets.only(top: 16.0)),
          TextFormField(
            controller: _kodeController,
            decoration: new InputDecoration(
              labelText: "Kode Registrasi Layanan",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(8.0),
                borderSide: new BorderSide(),
              ),
            ),
            keyboardType: TextInputType.text,
            style: new TextStyle(
              fontFamily: "NeoSansBold",
            ),
          ),
        ]);

    Future saveLayanan() async {

      if(_kodeController.text == ""){
        FunctionDart().setToast("Masukkan nomor dokumen yang akan dicari terlebih dahulu");
      }else{
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TrackingStatusScreen(_kodeController.text)),
        );  
      }
      
    }

    final saveButton = FunctionDart.customButton(context, saveLayanan,"Cari Layanan");

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    FutureBuilder(builder: (BuildContext context, AsyncSnapshot res) {
      var data = [
        {'Track': 'Berita', 'Status': 'Diterima'},
      ];

      final children = <Widget>[];
      for (var datas in data) {
        children.add(new Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: new InkWell(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: queryData.size.width / 3,
                        child: Text(
                          datas['Track'].toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontFamily: "NeoSansBold"),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  child: new Divider(
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 100,
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipicing elit,",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontFamily: "NeoSansBold"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
      }
      return new Column(
        children: children,
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: kodeRegistrasi,
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 24,top:16),
              child: saveButton,
            ),
            SizedBox(height: 8.0),
            BeritaWidget("prev"),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class FunctionDart {
  void setToast(String kata) {
    Fluttertoast.showToast(
        msg: "$kata",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  Future<String> getIdProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future.value(prefs.getString('loginId'));
  }

  String getExpirationDate() {
    var now = new DateTime.now();
    var expired = now.add(new Duration(days: 1));
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(expired);
    return formattedDate;
  }

  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, targetPath,
      quality: 88,
      rotate: 0,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  void setExpirationDate() async {
    String expirationDate = this.getExpirationDate();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('expirationDate', expirationDate);
  }

  Future<bool> checkExpirationDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime dateExpiration;
    try {
      dateExpiration = formatStringToDate(prefs.getString("expirationDate"));
      var dateNow = new DateTime.now();
      if (dateNow.isBefore(dateExpiration)) {
        return Future.value(false); //false jika masih belum expired
      } else {
        revokeAccess();
        return Future.value(true); //true jika sudah expired
      }
    } catch (Exception) {
      return Future.value(true); //true jika sudah expired

    }
  }

  void revokeAccess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('loginFolder');
    await prefs.remove('loginId');
    await prefs.remove('loginidUsaha');
    await prefs.remove('loginNama');
    await prefs.remove('loginEmail');
    await prefs.remove('loginRole');
    await prefs.remove('loginNamaRole');
    await prefs.remove('expirationDate');
  }

  DateTime formatStringToDate(String tanggal) {
    return DateTime.parse(tanggal);
  }

  static TextFormField textFormField(
      TextEditingController controller, TextInputType type, String label,
      [bool enabled = true]) {
    return TextFormField(
      keyboardType: type,
      enabled: enabled,
      autofocus: false,
      controller: controller,
      decoration: new InputDecoration(
        labelText: label,
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(8.0),
          borderSide: new BorderSide(),
        ),
      ),
    );
  }

  static openMap(String latitude, String longitude) async {
    double lat = double.parse(latitude);
    double long = double.parse(longitude);
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      FunctionDart().setToast("Lokasi belum ditentukan");
      throw 'Could not open the map.';
    }
  }

  static AppBar setAppBar(String text) {
    return AppBar(
      leading: BackButton(color: Colors.black),
      backgroundColor: Colors.white,
      title: Text(text, style: TextStyle(color: Colors.black87)),
    );
  }

  static Align saveButton(
    BuildContext context,
    VoidCallback action,
  ) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 22.0),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          minWidth: queryData.size.width,
          height: queryData.size.height / 13,
          onPressed: () => action(),
          color: Color(0xff2ECC71),
          child: Text('Simpan', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  static Align customButton(
      BuildContext context, VoidCallback action, String text) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 22.0),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          minWidth: queryData.size.width,
          height: queryData.size.height / 13,
          onPressed: () => action(),
          color: Color(0xff2ECC71),
          child: Text(text, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

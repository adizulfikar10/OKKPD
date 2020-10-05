import 'dart:convert';
import 'package:okkpd_mobile/constants/key.dart';
import 'package:http/http.dart' as http;
import 'package:okkpd_mobile/model/produkModel.dart';
import 'package:okkpd_mobile/model/responseModel.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProdukRepo {
  Future<bool> produkRepo(ProdukRepo produkVar, String jenis) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idUsaha = prefs.getString('loginidUsaha');

    List<ProdukRepo> produks = List();
    produks.add(produkVar);

    var url = '${Keys.APIURL}layanan/$idUsaha/daftar/$jenis';
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(produks));

    var resp = ResponseModel.fromJson(json.decode(response.body));
    FunctionDart().setToast(resp.message);
    if (response.statusCode != 200) {
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  Future<bool> postProduk(List<ProdukModel> export, String jenis) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idUsaha = prefs.getString('loginidUsaha');
    
    var url = '${Keys.APIURL}layanan/$idUsaha/daftar/$jenis';
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(export));

    var resp = ResponseModel.fromJson(json.decode(response.body));
    FunctionDart().setToast(resp.message);
    if (response.statusCode != 200) {
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}

import 'dart:convert';
import 'package:okkpd_mobile/constants/key.dart';
import 'package:http/http.dart' as http;
import 'package:okkpd_mobile/model/kelompokKomoditasModel.dart';
import 'package:okkpd_mobile/model/komoditasModel.dart';
import 'package:okkpd_mobile/model/responseModel.dart';
import 'package:okkpd_mobile/model/sektorKomoditasModel.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KomoditasRepo {
  Future<bool> postKomoditas(
      List<KomoditasModel> komoditas, String jenis) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idUsaha = prefs.getString('loginidUsaha');

    var url = '${Keys.APIURL}layanan/$idUsaha/daftar/$jenis';
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(komoditas));

    var resp = ResponseModel.fromJson(json.decode(response.body));
    FunctionDart().setToast(resp.message);
    if (response.statusCode != 200) {
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  Future getAllKomoditas() async {
    List _postList = [];
    var url = '${Keys.APIURL}komoditas/allKomoditas';
    var response = await http.get(url);
    final values = await json.decode(response.body);
    if (values['DATA'].length > 0) {
      for (int i = 0; i < values['DATA'].length; i++) {
        _postList.add(values['DATA'][i]);
      }
    }
    return _postList;
  }

  Future getSektor() async {
    List<SektorKomoditasModel> _postList = [];
    var url = '${Keys.APIURL}komoditas/sektor';
    var response = await http.get(url);
    final values = await json.decode(response.body);

    if (values['DATA'].length > 0) {
      for (int i = 0; i < values['DATA'].length; i++) {
        var sektor = SektorKomoditasModel.fromJson(values['DATA'][i]);
        _postList.add(sektor);
      }
    }
    return _postList;
  }

  Future getKelompok(String id) async {
    List<KelompokKomoditasModel> _postList = [];
    var url = '${Keys.APIURL}komoditas/sektor/$id/kelompok';
    var response = await http.get(url);
    final values = await json.decode(response.body);

    if (values['DATA'].length > 0) {
      for (int i = 0; i < values['DATA'].length; i++) {
        var kelompok = KelompokKomoditasModel.fromJson(values['DATA'][i]);
        _postList.add(kelompok);
      }
    }
    return _postList;
  }

  Future getKomoditas(String id, String kelompok) async {
    List<KomoditasModel> _postList = [];
    var url = '${Keys.APIURL}komoditas/sektor/$id/kelompok/$kelompok';
    var response = await http.get(url);
    final values = await json.decode(response.body);

    if (values['DATA'] == null) {
      return null;
    } else {
      for (int i = 0; i < values['DATA'].length; i++) {
        var komoditas = KomoditasModel.fromJson(values['DATA'][i]);
        _postList.add(komoditas);
      }
      return _postList;
    }
  }
}

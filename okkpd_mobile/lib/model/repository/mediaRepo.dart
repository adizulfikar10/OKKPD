import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:okkpd_mobile/constants/key.dart';
import 'package:http/http.dart' as http;
import 'package:okkpd_mobile/model/dokumenModel.dart';
import 'package:okkpd_mobile/model/mediaModel.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MediaRepo {
  Future<String> getIdUsaha() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future.value(prefs.getString('loginidUsaha'));
  }

  Future<String> getIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future.value(prefs.getString('loginId'));
  }

  Future getMedia(String kodeLayanan, String jenis) async {
    String idUsaha = await getIdUsaha();
    List<MediaModel> _postList = [];
    var url = '${Keys.APIURL}layanan/$idUsaha/dokumen/$kodeLayanan/$jenis';
    var response = await http.get(url);
    final values = await json.decode(response.body);

    if (response.statusCode != 200) {
      return null;
    } else {
      for (int i = 0; i < values['DATA'].length; i++) {
        var sektor = MediaModel.fromJson(values['DATA'][i]);
        _postList.add(sektor);
      }
      return _postList;
    }
  }

  Future getUploadedMedia(String kodeLayanan) async {
    List<DokumenModel> _postList = [];
    var url = '${Keys.APIURL}layanan/dinas/dokumen/$kodeLayanan';
    print(url);
    var response = await http.get(url);
    final values = await json.decode(response.body);

    if (response.statusCode != 200) {
      return null;
    } else {
      for (int i = 0; i < values['DATA'].length; i++) {
        var media = DokumenModel.fromJson(values['DATA'][i]);
        _postList.add(media);
      }
      return _postList;
    }
  }


  Future getMediaById(String kodeDokumen) async {
    List<MediaModel> _postList = [];
    String idUser = await getIdUser();
    var url = '${Keys.APIURL}user/$idUser/dokumen_media/jenis/$kodeDokumen';
    var response = await http.get(url);
    final values = await json.decode(response.body);

    if (response.statusCode != 200) {
      return null;
    } else {
      for (int i = 0; i < values['DATA'].length; i++) {
        var sektor = MediaModel.fromJson(values['DATA'][i]);
        _postList.add(sektor);
      }
      return _postList;
    }
  }

  Future getStatusDokumen() async {
    String idUser = await getIdUser();
    var url = '${Keys.APIURL}user/$idUser/dokumen_media';
    var response = await http.get(url);
    final values = await json.decode(response.body);

    List<MediaModel> _postList = [];

    if (response.statusCode != 200) {
      return null;
    } else {
      for (int i = 0; i < values['DATA'].length; i++) {
        var sektor = MediaModel.fromJson(values['DATA'][i]);
        _postList.add(sektor);
      }
      return _postList;
    }
  }

  Future<bool> deleteMedia(String data) async {
    String idUser = await getIdUser();
    var url = "${Keys.APIURL}user/$idUser/dokumen_media/delete";
    var response = await http.post(url, body: {'id_media': data});
    var message = "Data berhasil dihapus";
    final values = await json.decode(response.body);

    if (response.statusCode != 200) {
      message = values['MESSAGE'];
      FunctionDart().setToast("$message Eror code :${response.statusCode}");
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  Future<bool> uploadMedia(File dokumen, String kodeDokumen) async {
    Response response;
    Dio dio = new Dio();

    String idUsaha = await getIdUsaha();
    String idUser = await getIdUser();
    List<String> nama = dokumen.path.split("/");
    var url = '${Keys.APIURL}layanan/$idUsaha/unggah_media';

    FormData formData = FormData.fromMap({
      "kode_dokumen": kodeDokumen,
      "id_user": idUser,
      "gambar": await MultipartFile.fromFile(dokumen.path,
          filename: nama[nama.length - 1])
    });
    response = await dio.post(url, data: formData);

    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}

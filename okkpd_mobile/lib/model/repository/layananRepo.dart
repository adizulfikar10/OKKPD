import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:okkpd_mobile/constants/key.dart';
import 'package:http/http.dart' as http;
import 'package:okkpd_mobile/model/layananModel.dart';
import 'package:okkpd_mobile/model/repository/SharedPrefRepo.dart';
import 'package:okkpd_mobile/model/trackLayananModel.dart';
import 'package:okkpd_mobile/model/trackSertifikatModel.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../dokumenInspeksiModel.dart';

class LayananRepo {
  Future getLayanan(String kodeLayanan, String status) async {
    if (status == null) {
      status = "%";
    } else if (status == '%') {
      status = '%';
    } else if (status == 'Semua') {
      status = '%';
    } else if (status == 'Lengkapi Dokumen') {
      status = '99';
    } else if (status == 'Menunggu') {
      status = '0';
    } else if (status == 'Diterima') {
      status = '1';
    } else if (status == 'Ditolak') {
      status = '2';
    }

    if (kodeLayanan == null) {
      kodeLayanan = "%";
    }

    String idUsaha = await SharedPrefRepo().getIdUsaha();
    List<LayananModel> _postList = [];
    var url =
        '${Keys.APIURL}layanan/$idUsaha/list?layanan=$kodeLayanan&status=$status';
    var response = await http.get(url);
    final values = await json.decode(response.body);

    if (response.statusCode != 200) {
      return null;
    } else {
      for (int i = 0; i < values['DATA'].length; i++) {
        var sektor = LayananModel.fromJson(values['DATA'][i]);
        _postList.add(sektor);
      }
      return _postList;
    }
  }

  Future getLayananDiterima() async {
    String role = await SharedPrefRepo().getRole();
    String idUser = await SharedPrefRepo().getIdUser();
    List<LayananModel> _postList = [];
    var url = '${Keys.APIURL}layanan/dinas/diterima/$role/$idUser';
    print('URL : $url');
    var response = await http.get(url);
    final values = json.decode(response.body);

    if (response.statusCode != 200) {
      return null;
    } else {
      for (int i = 0; i < values['DATA'].length; i++) {
        var layanan = LayananModel.fromJson(values['DATA'][i]);
        _postList.add(layanan);
      }
      return _postList;
    }
  }

  Future getRiwayatLayanan() async {
    String role = await SharedPrefRepo().getRole();
    String idUser = await SharedPrefRepo().getIdUser();
    List<LayananModel> _postList = [];
    var url = '${Keys.APIURL}layanan/dinas/riwayat/$role/$idUser';
    print('URL : $url');
    var response = await http.get(url);
    final values = json.decode(response.body);

    if (response.statusCode != 200) {
      return null;
    } else {
      for (int i = 0; i < values['DATA'].length; i++) {
        var layanan = LayananModel.fromJson(values['DATA'][i]);
        _postList.add(layanan);
      }
      return _postList;
    }
  }

  Future getLayananDitolak() async {
    String role = await SharedPrefRepo().getIdUser();
    List<LayananModel> _postList = [];
    var url = '${Keys.APIURL}layanan/dinas/ditolak/$role';
    var response = await http.get(url);
    final values = json.decode(response.body);

    if (response.statusCode != 200) {
      return null;
    } else {
      for (int i = 0; i < values['DATA'].length; i++) {
        var layanan = LayananModel.fromJson(values['DATA'][i]);
        _postList.add(layanan);
      }
      return _postList;
    }
  }

  Future trackSertifikat(String kodeTracking) async {
    TrackSertifikatModel _postList;
    var url = '${Keys.APIURL}tracking/sertifikat';
    var response = await http.post(url, body: {'tracking_data': kodeTracking});
    final values = await json.decode(response.body);

    if (response.statusCode != 200) {
      return null;
    } else {
      for (int i = 0; i < values['DATA'].length; i++) {
        var data = TrackSertifikatModel.fromJson(values['DATA'][i]);
        _postList = (data);
      }
      return _postList;
    }
  }

  Future trackLayanan(String kodeTracking) async {
    List<TrackLayananModel> _postList = [];
    var url = '${Keys.APIURL}tracking/layanan';
    var response = await http.post(url, body: {'tracking_data': kodeTracking});
    final values = await json.decode(response.body);

    if (response.statusCode != 200) {
      FunctionDart().setToast(values['MESSAGE']);
      return null;
    } else {
      for (int i = 0; i < values['DATA'].length; i++) {
        var sektor = TrackLayananModel.fromJson(values['DATA'][i]);
        _postList.add(sektor);
      }
      return _postList;
    }
  }

  Future<bool> simpanLayanan(String kodeLayanan) async {
    String idUsaha = await SharedPrefRepo().getIdUsaha();
    var url = '${Keys.APIURL}layanan/$idUsaha/simpan_dokumen';
    var response = await http.post(url, body: {'id_layanan': kodeLayanan});
    final values = await json.decode(response.body);
    FunctionDart().setToast(values['MESSAGE']);

    if (response.statusCode != 200) {
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  Future<bool> tolakLayanan(String kodeLayanan, String alasanPenolakan) async {
    String idUser = await SharedPrefRepo().getIdUser();
    var url = '${Keys.APIURL}layanan/tolak';
    var response = await http.post(url, body: {
      'id_layanan': kodeLayanan,
      "id_penolak": idUser,
      "alasan_penolakan": alasanPenolakan
    });
    final values = await json.decode(response.body);
    FunctionDart().setToast(values['MESSAGE']);

    if (response.statusCode != 200) {
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  Future<bool> terimaLayanan(String kodeLayanan) async {
    String role = await SharedPrefRepo().getRole();
    var url = '${Keys.APIURL}layanan/terima';
    var response =
        await http.post(url, body: {'id_layanan': kodeLayanan, "role": role});
    final values = await json.decode(response.body);
    FunctionDart().setToast(values['MESSAGE']);

    if (response.statusCode != 200) {
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  Future getDokumenUpload(String idLayanan) async {
    List<DokumenInspeksiModel> _postList = [];
    var url = '${Keys.APIURL}layanan/dinas/dokumen_inspeksi/$idLayanan';
    var response = await http.get(url);
    final values = await json.decode(response.body);

    if (response.statusCode != 200) {
      FunctionDart().setToast(values['MESSAGE']);
      return null;
    } else {
      for (int i = 0; i < values['DATA'].length; i++) {
        var dokumen = DokumenInspeksiModel.fromJson(values['DATA'][i]);
        _postList.add(dokumen);
      }
      return _postList;
    }
  }

  Future getGambar(String idLayanan,String idGambar) async {
    DokumenInspeksiModel _postList;
    var url = '${Keys.APIURL}layanan/dinas/dokumen_inspeksi/$idLayanan/gambar/$idGambar';
    var response = await http.get(url);
    final values = await json.decode(response.body);

    if (response.statusCode != 200) {
      FunctionDart().setToast(values['MESSAGE']);
      return null;
    } else {
        var dokumen = DokumenInspeksiModel.fromJson(values['DATA']);
        _postList = dokumen;
      return _postList;
    }
  }



  Future<bool> uploadDokumenInspeksi(File dokumen, String idLayanan,String idGambar, int isNew) async {
    Response response;
    Dio dio = new Dio();
    List<String> nama = dokumen.path.split("/");
    var url = '${Keys.APIURL}layanan/dinas/dokumen_inspeksi/$idLayanan/unggah';

    File compressedFile = await FunctionDart().testCompressAndGetFile(dokumen, dokumen.path);

    FormData formData = FormData.fromMap({
      "id_gambar": idGambar,
      "is_new": isNew,
      "gambar": await MultipartFile.fromFile(compressedFile.path,
          filename: nama[nama.length - 1])
    });
    try{
      response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        print("HASIL : $response");
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    }catch(e){
      print("ERROR : ${response.statusMessage}");
    }

  }

  Future<bool> simpanDokumenInspeksi(String idLayanan) async {
    var url = '${Keys.APIURL}layanan/dinas/dokumen_inspeksi/$idLayanan/simpan';
    var response = await http.post(url);
    if (response.statusCode != 200) {
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}

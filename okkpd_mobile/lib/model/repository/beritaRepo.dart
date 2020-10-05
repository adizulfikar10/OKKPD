import 'dart:convert';

import 'package:okkpd_mobile/constants/key.dart';
import 'package:http/http.dart' as http;
import 'package:okkpd_mobile/model/beritaModel.dart';
import 'package:okkpd_mobile/model/responseModel.dart';

class BeritaRepo {
  Future getBerita(String url) async {
    List<BeritaModel> _postList = [];
    var response = await http.get(url);
    final values = await json.decode(response.body);

    if (response.statusCode != 200) {
      return null;
    } else {
      for (int i = 0; i < values['DATA'].length; i++) {
        var berita = BeritaModel.fromJson(values['DATA'][i]);
        _postList.add(berita);
      }
      return _postList;
    }
  }

  Future viewBerita(String idBerita) async {
    var url = '${Keys.APIURL}berita/view/' + idBerita;
    var response = await http.get(url);
    var resp = ResponseModel.fromJson(json.decode(response.body));
    if (response.statusCode != 200) {
      return null;
    } else {
      return BeritaModel.fromJson(resp.data);
    }
  }

  Future getPreview() async {
    var url = '${Keys.APIURL}berita/prev';
    return getBerita(url);
  }

  Future getAll() async {
    var url = '${Keys.APIURL}berita/all';
    return getBerita(url);
  }
}

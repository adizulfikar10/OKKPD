import 'dart:convert';

import 'package:okkpd_mobile/constants/key.dart';
import 'package:http/http.dart' as http;
import 'package:okkpd_mobile/model/notifikasiModel.dart';
import 'package:okkpd_mobile/model/responseModel.dart';
import 'package:okkpd_mobile/model/userModel.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo {
  static Future<String> getIdProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future.value(prefs.getString('loginId'));
  }

  Future<UserModel> getProfile(String idUser) async {
    var url = '${Keys.APIURL}user/$idUser';
    var response = await http.get(url);
    var resp = ResponseModel.fromJson(json.decode(response.body));

    if (response.statusCode != 200) {
      FunctionDart().setToast("Ups! Ada kendala pada server.");
      return Future.value(null);
    } else {
      var user = UserModel.fromJson(resp.data);
      return Future.value(user);
    }
  }

  Future<bool> updateProfile(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idUser = await getIdProfile();
    var url = '${Keys.APIURL}user/$idUser';
    var response =
        await http.patch(url, body: {"nama_lengkap": user.namaLengkap});
    var resp = ResponseModel.fromJson(await json.decode(response.body));

    if (response.statusCode != 200) {
      FunctionDart().setToast('Tidak ada data yang diubah');
      return Future.value(false);
    } else {
      FunctionDart().setToast(resp.message);
      await prefs.setString('loginNama', user.namaLengkap);
      return Future.value(true);
    }
  }

  Future<bool> updatePassword(String password, String ulangPassword) async {
    var idUser = await getIdProfile();
    var url = '${Keys.APIURL}user/$idUser/password';
    var response = await http.patch(url,
        body: {"password": password, "password_ulang": ulangPassword});
    var resp = ResponseModel.fromJson(await json.decode(response.body));
    FunctionDart().setToast(resp.message);
    if (response.statusCode != 200) {
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  Future getNotifikasi() async {
    var idUser = await getIdProfile();
    var url = '${Keys.APIURL}user/$idUser/notifikasi';
    var response = await http.get(url);
    final values = await json.decode(response.body);

    List<NotifikasiModel> _postList = [];

    if (response.statusCode != 200) {
      return null;
    } else {
      for (int i = 0; i < values['DATA'].length; i++) {
        var notif = NotifikasiModel.fromJson(values['DATA'][i]);
        _postList.add(notif);
      }
      return _postList;
    }
  }

  Future<int> countNotifikasi() async {
    var idUser = await getIdProfile();
    var url = '${Keys.APIURL}user/$idUser/countNotifikasi';
    var response = await http.get(url);

    var resp = ResponseModel.fromJson(await json.decode(response.body));
    if (response.statusCode == 200) {
      return Future.value(int.parse(resp.data['unreadNotification']));
    } else {
      return Future.value(0);
    }
  }

  Future<bool> readAllNotif() async {
    var idUser = await getIdProfile();
    var url = '${Keys.APIURL}user/$idUser/readAllNotif';
    var response = await http.post(url);
    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  static Future<bool> updateLocation(String long, String lat) async {
    var idUser = await getIdProfile();
    var url = '${Keys.APIURL}user/$idUser/location/update';
    var setBody = {"latitude": lat, "longitude": long};

    var response = await http.post(url,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: setBody);

    var resp = json.decode(response.body);

    if (response.statusCode == 200) {
      FunctionDart().setToast(resp['MESSAGE']);
      return Future.value(true);
    } else {
      FunctionDart().setToast(resp['MESSAGE']);
      return Future.value(false);
    }
  }
}

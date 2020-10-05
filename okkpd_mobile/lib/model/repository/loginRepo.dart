import 'dart:convert';

import 'package:okkpd_mobile/constants/key.dart';
import 'package:http/http.dart' as http;
import 'package:okkpd_mobile/model/responseModel.dart';
import 'package:okkpd_mobile/model/userModel.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepo {
  Future<bool> loginProcess(String username, String password) async {
    var url = '${Keys.APIURL}login';

    var response = await http.post(url,
        body: {'username': username, 'password': password, "role": "pelaku"});
    var message = "Login Sukses";
    var resp = ResponseModel.fromJson(json.decode(response.body));
    if (response.statusCode != 200) {
      message = resp.message;
      FunctionDart().setToast("$message Eror code :${response.statusCode}");
      return Future.value(false);
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = UserModel.fromJson(resp.data);
      await prefs.setString('loginFolder', user.folder);
      await prefs.setString('loginId', user.idUser);
      await prefs.setString('loginidUsaha', user.idIdentitasUsaha);
      await prefs.setString('loginNama', user.namaLengkap);
      await prefs.setString('loginEmail', user.username);
      await prefs.setString('loginRole', user.kodeRole);
      return Future.value(true);
    }
  }

  Future loginUserProses(String username, String password) async {
    var url = '${Keys.APIURL}login_user';
    List<UserModel> _postList = [];

    var response = await http
        .post(url, body: {'username': username, 'password': password});
    var message = "Login Sukses";

    final values = await json.decode(response.body);

    if (response.statusCode != 200) {
      message = values['MESSAGE'];
      FunctionDart().setToast("$message Eror code :${response.statusCode}");
      return null;
    } else {
      for (int i = 0; i < values['DATA'].length; i++) {
        var sektor = UserModel.fromJson(values['DATA'][i]);
        _postList.add(sektor);
      }
      return _postList;
    }
  }

  Future<bool> verification(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('loginFolder', user.folder);
    await prefs.setString('loginId', user.idUser);
    await prefs.setString('loginidUsaha', user.idIdentitasUsaha);
    await prefs.setString('loginNama', user.namaLengkap);
    await prefs.setString('loginEmail', user.username);
    await prefs.setString('loginRole', user.kodeRole);
    await prefs.setString('loginNamaRole', user.namaRole);
    FunctionDart().setExpirationDate();
    return Future.value(true);
  }

  void logoutProcess() async {
    FunctionDart().revokeAccess();
  }
}

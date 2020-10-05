import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefRepo{

  Future<String> getPref(String prefName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future.value(prefs.getString(prefName));
  }
  Future<String> getIdUsaha() async {
    return getPref('loginidUsaha');
  }
  Future<String> getRole() async {
    return getPref('loginRole');
  }
  Future<String> getLoginFolder() async {
    return getPref('loginFolder');
  }
  Future<String> getIdUser() async {
    return getPref('loginId');
  }
  Future<String> getNamaLengkap() async {
    return getPref('loginNama');
  }
  Future<String> getEmail() async {
    return getPref('loginEmail');
  }
  Future<String> getNamaRole() async {
    return getPref('loginNamaRole');
  }

}
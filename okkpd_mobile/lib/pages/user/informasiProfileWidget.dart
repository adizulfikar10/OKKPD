import 'package:flutter/material.dart';
import 'package:okkpd_mobile/model/repository/SharedPrefRepo.dart';

import 'package:okkpd_mobile/model/repository/userRepo.dart';
import 'package:okkpd_mobile/model/userModel.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../tools/CustomWidget.dart';

class InformasiProfilescreen extends StatefulWidget {
  @override
  _InformasiProfilescreen createState() => _InformasiProfilescreen();
}

class _InformasiProfilescreen extends State<InformasiProfilescreen> {
  var _namaController = TextEditingController();
  var _emailController = TextEditingController();
  var _jabatanController = TextEditingController();
  String idUser;

  bool isLoading = true;

  Future setUser() async {
    String idUser = await SharedPrefRepo().getIdUser();
    UserModel user = await UserRepo().getProfile(idUser);
    if (user != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      idUser = prefs.getString('loginId');
      prefs.setString('loginNama', user.namaLengkap);
      _namaController.text = user.namaLengkap;
      _emailController.text = prefs.getString('loginEmail');
      _jabatanController.text = prefs.getString('loginRole');

      setState(() {
        if (_namaController.text != '') {
          isLoading = false;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setUser();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    ProgressDialog pr;
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    Future updateProfile() async {
      if (_namaController.text.isEmpty) {
        FunctionDart().setToast("Nama harus diisi");
      } else {
        pr.show();
        UserModel user = new UserModel(
            '', '', '', '', '', '', '', '', '', '', '', '', '', '', '');
        user.namaLengkap = _namaController.text;
        Future<bool> resultLogin = UserRepo().updateProfile(user);
        if (await resultLogin == true) {
          pr.dismiss();
          setUser();
        } else {
          pr.dismiss();
        }
      }
    }

    final saveButton = FunctionDart.saveButton(context, updateProfile);

    final nama = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FunctionDart.textFormField(
              _namaController, TextInputType.text, 'Nama Lengkap')
        ]);

    final email =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      FunctionDart.textFormField(_emailController, TextInputType.text, 'Email')
    ]);

    final jabatan =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      FunctionDart.textFormField(
          _jabatanController, TextInputType.text, 'Akun', false)
    ]);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: FunctionDart.setAppBar("Informasi Profil"),
      body: (isLoading)
          ? CustomWidget().loadingWidget()
          : Padding(
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  nama,
                  SizedBox(height: 20.0),
                  email,
                  SizedBox(height: 20.0),
                  jabatan,
                  Spacer(),
                  saveButton,
                ],
              ),
            ),
    );
  }
}

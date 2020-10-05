import 'package:flutter/material.dart';
import 'package:okkpd_mobile/model/repository/userRepo.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';
import 'package:progress_dialog/progress_dialog.dart';

class GantiPasswordscreen extends StatefulWidget {
  @override
  _GantiPasswordscreen createState() => _GantiPasswordscreen();
}

class _GantiPasswordscreen extends State<GantiPasswordscreen> {
  var _passwordBaruController = TextEditingController();
  var _passwordBaru2Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    ProgressDialog pr;
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    Future updateProfile() async {
      if (_passwordBaruController.text.isEmpty ||
          _passwordBaru2Controller.text.isEmpty) {
        FunctionDart().setToast("Password harus diisi");
      } else {
        pr.show();
        Future<bool> resultLogin = UserRepo().updatePassword(
            _passwordBaruController.text, _passwordBaru2Controller.text);
        if (await resultLogin == true) {
          pr.dismiss();
          _passwordBaruController.clear();
          _passwordBaru2Controller.clear();
        } else {
          pr.dismiss();
        }
      }
    }

    final saveButton = FunctionDart.saveButton(context, updateProfile);

    final passwordBaru =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      FunctionDart.textFormField(
          _passwordBaruController, TextInputType.text, 'Password Baru')
    ]);

    final passwordBaru2 =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      FunctionDart.textFormField(
          _passwordBaru2Controller, TextInputType.text, 'Ulangi Password')
    ]);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: FunctionDart.setAppBar("Ubah Password"),
      body: Padding(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            passwordBaru,
            SizedBox(height: 20.0),
            passwordBaru2,
            SizedBox(height: 20.0),
            Spacer(),
            saveButton,
          ],
        ),
      ),
    );
  }
}

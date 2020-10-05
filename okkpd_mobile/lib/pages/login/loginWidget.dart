import 'package:flutter/material.dart';
import 'package:okkpd_mobile/constants/key.dart';
import 'package:okkpd_mobile/model/userModel.dart';
import 'package:okkpd_mobile/pages/aktorDinas/dashboardDinasScreen.dart';
import 'package:okkpd_mobile/pages/login/pilihRoleScreen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:okkpd_mobile/model/repository/loginRepo.dart';
import 'package:okkpd_mobile/pages/homeScreen.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';

class LoginWidget extends StatefulWidget {
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();
  @override
  LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> {
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr;
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    Future loginProcess() async {
      if (_usernameController.text.isEmpty ||
          _passwordController.text.isEmpty) {
        FunctionDart().setToast("Username atau password masih kosong");
      } else {
        pr.show();
        List<UserModel> resultLogin = await LoginRepo().loginUserProses(
            _usernameController.text, _passwordController.text);
        if (resultLogin != null || resultLogin.length > 0) {
          pr.dismiss();
          if (resultLogin.length == 1) {
            if (await LoginRepo().verification(resultLogin[0])) {
              if (resultLogin[0].kodeRole != 'pelaku') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DashboardDinasScreen()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen('0')),
                );
              }
            }
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PilihRoleScreen(resultLogin)),
            );
          }
        } else {
          pr.dismiss();
          Navigator.pop(context);
        }
      }
    }

    final logo = Hero(
      tag: 'hero',
      child: Image(height: 70, image: AssetImage('assets/logo.png')),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: _usernameController,
      decoration: new InputDecoration(
        labelText: "Username",
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(8.0),
          borderSide: new BorderSide(),
        ),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: _passwordController,
      decoration: new InputDecoration(
        labelText: "Password",
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(8.0),
          borderSide: new BorderSide(),
        ),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        child: FunctionDart.customButton(context, loginProcess, "Log In"),
        // MaterialButton(
        //   minWidth: 200.0,
        //   height: 42.0,
        //   onPressed: () {
        //     loginProcess();
        //   },
        //   color: Colors.lightBlueAccent,
        //   child: Text('Log In', style: TextStyle(color: Colors.white)),
        // ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Lupa Kata Sandi?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );
    final signupLabel = FlatButton(
      child: Text(
        'Daftar',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return SafeArea(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            Align(
              child: Text(
                "LOGIN",
                style: Keys().bigBoldFontSiza,
              ),
            ),
            SizedBox(height: 24.0),
            email,
            SizedBox(height: 16.0),
            password,
            SizedBox(height: 8.0),
            loginButton,
            forgotLabel,
            signupLabel
          ],
        ),
      ),
    );
  }
}

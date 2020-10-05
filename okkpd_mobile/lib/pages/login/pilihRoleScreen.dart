import 'package:flutter/material.dart';
import 'package:okkpd_mobile/constants/key.dart';
import 'package:okkpd_mobile/model/repository/loginRepo.dart';
import 'package:okkpd_mobile/model/userModel.dart';
import 'package:okkpd_mobile/pages/aktorDinas/dashboardDinasScreen.dart';
import 'package:okkpd_mobile/pages/homeScreen.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';

class PilihRoleScreen extends StatefulWidget {
  PilihRoleScreen(this.resultLogin);
  final List<UserModel> resultLogin;
  @override
  _PilihRoleScreenState createState() => _PilihRoleScreenState(resultLogin);
}

class _PilihRoleScreenState extends State<PilihRoleScreen> {
  int selected = -1;
  UserModel selectedUser;
  final List<UserModel> resultLogin;
  _PilihRoleScreenState(this.resultLogin);

  Widget choice(UserModel user, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = index;
          selectedUser = user;
        });
      },
      child: Card(
        elevation: 4,
        child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  width: 54,
                  height: 54,
                  decoration: new BoxDecoration(
                    color: Colors.grey,
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(100.0)),
                  ),
                  child: IconButton(
                    icon: new Icon(Icons.person),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ),
                Text(
                  user.namaLengkap,
                  style: Keys().mediumBoldFontSize,
                ),
                Text(user.kodeRole),
                SizedBox(height: 8.0),
                isChecked(index),
              ],
            )),
      ),
    );
  }

  Widget isChecked(int index) {
    if (selected == index) {
      return Icon(Icons.check_circle, color: Colors.green);
    } else {
      return SizedBox(
        height: 16,
      );
    }
  }

  Future loginProses() async {
    if (await LoginRepo().verification(resultLogin[selected])) {
      if (resultLogin[selected].kodeRole != 'pelaku') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardDinasScreen()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen('0')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Masuk Sebagai"),
        ),
        backgroundColor: Colors.blue,
        body: Container(
            child: Column(
          children: <Widget>[
            GridView.count(
              shrinkWrap: true,
              mainAxisSpacing: 1,
              padding:
                  EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
              crossAxisCount: 2,
              children: List.generate(resultLogin.length, (index) {
                return Container(
                  child: choice(resultLogin[index], index),
                );
              }),
            ),
          ],
        )),
        bottomSheet: new SizedBox(
          width: double.infinity,
          child: MaterialButton(
              elevation: 3,
              padding: EdgeInsets.all(16),
              onPressed: () {
                if (selected == -1) {
                  FunctionDart().setToast("Pilih dahulu role anda");
                } else {
                  loginProses();
                }
              },
              child: Container(
                child: Text("Lanjut"),
              )),
        ));
  }
}

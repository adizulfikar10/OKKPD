import 'package:flutter/material.dart';
import 'package:okkpd_mobile/model/repository/userRepo.dart';
import 'package:okkpd_mobile/pages/aktorDinas/infoUserWidget.dart';
import 'package:okkpd_mobile/pages/aktorDinas/menuWidget.dart';
import 'package:okkpd_mobile/tools/CustomWidget.dart';

class DashboardDinasScreen extends StatefulWidget {
  @override
  _DashboardDinasScreenState createState() => _DashboardDinasScreenState();
}

class _DashboardDinasScreenState extends State<DashboardDinasScreen> {
  int totalNotif = 0;

  @override
  void initState() {
    super.initState();
    getNotif();
  }

  void getNotif() async {
    Future<int> total = UserRepo().countNotifikasi();
    if (await total > 0) {
      setState(() {
        totalNotif = 2;
      });
    } else {
      setState(() {
        totalNotif = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
            appBar: AppBar(
              elevation: 3,
              iconTheme: IconThemeData(color: Color.fromRGBO(0, 0, 0, 87)),
              backgroundColor: Colors.white,
              actions: <Widget>[CustomWidget().notifIcon(context, totalNotif)],
              leading: new Container(),
              title: Container(
                  width: 130,
                  height: 100,
                  alignment: AlignmentDirectional(2.0, 0.0),
                  child: Image(image: AssetImage('assets/logo.png'))),
              centerTitle: true,
            ),
            body: Column(
              children: <Widget>[InfoUserWidget(), MenuWidget()],
            )));
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Keluar Aplikasi'),
            content: new Text('Apakah anda ingin keluar aplikasi?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Tidak'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Ya'),
              ),
            ],
          ),
        ) ??
        false;
  }
}

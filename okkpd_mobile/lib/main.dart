import 'dart:async';

import 'package:flutter/material.dart';
import 'package:okkpd_mobile/constants/theme.dart' as theme;
import 'package:okkpd_mobile/pages/aktorDinas/dashboardDinasScreen.dart';
import 'package:okkpd_mobile/pages/aktorDinas/layananDiterimaScreen.dart';
import 'package:okkpd_mobile/pages/aktorDinas/layananDitolakScreen.dart';
import 'package:okkpd_mobile/pages/aktorDinas/riwayatLayananScreen.dart';
import 'package:okkpd_mobile/pages/homeScreen.dart';
import 'package:okkpd_mobile/pages/layanan/tambah/tambahKomoditasScreen.dart';
import 'package:okkpd_mobile/pages/login/loginScreen.dart';
import 'package:okkpd_mobile/pages/layanan/primaTigaScreen.dart';
import 'package:okkpd_mobile/pages/layanan/psatScreen.dart';
import 'package:okkpd_mobile/pages/layanan/hcScreen.dart';
import 'package:okkpd_mobile/pages/layanan/primaDuaScreen.dart';
import 'package:okkpd_mobile/pages/layanan/rumahKemasScreen.dart';
import 'package:okkpd_mobile/pages/media/mediaScreen.dart';
import 'package:flutter/services.dart';
import 'package:okkpd_mobile/pages/surveiPelanggan/surveiScreen.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:okkpd_mobile/pages/guest/homeGuestScreen.dart';
import 'package:okkpd_mobile/pages/guest/kontakScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OKKPD',
      theme: ThemeData(
        fontFamily: 'NeoSans',
        primaryColor: theme.menuBluebird,
        accentColor: theme.menuBluebird,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new LoginScreen(),
        '/homescreen': (BuildContext context) => new HomeScreen('0'),
        '/dashboardDinas': (BuildContext context) => new DashboardDinasScreen(),
        '/hcscreen': (BuildContext context) => new Hcscreen(),
        '/psatscreen': (BuildContext context) => new Psatscreen(),
        '/primaDuascreen': (BuildContext context) => new PrimaduaScreen(),
        '/primaTigascreen': (BuildContext context) => new PrimatigaScreen(),
        '/rumahKemas': (BuildContext context) => new Rumahkemas(),
        '/mediaScreen': (BuildContext context) => new Mediascreen(),
        '/homeGuest': (BuildContext context) => new HomeGuestScreen(),
        '/kontak': (BuildContext context) => new KontakScreen(),
        '/surveiPelanggan': (BuildContext context) => new SurveiScreen(),
        '/layananDiterima': (BuildContext context) =>
            new LayananDiterimaWidget(),
        '/layananDitolak': (BuildContext context) =>
        new LayananDitolakWidget(),
        '/riwayatLayanan': (BuildContext context) =>
        new RiwayatLayananScreen(),
        '/tambahKomoditas': (BuildContext context) =>
            new TambahKomoditasScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationAwal() {
    Navigator.of(context).pushReplacementNamed('/homescreen');
  }

  void navigationPage() async {
    bool isExpired = await FunctionDart().checkExpirationDate();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("loginId") != null) {
      if (isExpired == false) {
        if (prefs.getString("loginRole") == 'pelaku') {
          Navigator.of(context).pushReplacementNamed('/homescreen');
        } else {
          Navigator.of(context).pushReplacementNamed('/dashboardDinas');
        }
      } else {
        FunctionDart()
            .setToast("Sesi anda telah berakhir, silahkan login kembali");
        Navigator.of(context).pushReplacementNamed('/homeGuest');
      }
    } else {
      Navigator.of(context).pushReplacementNamed('/homeGuest');
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Image.asset('assets/logo.png'),
      ),
    );
  }
}

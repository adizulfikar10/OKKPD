import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:okkpd_mobile/pages/guest/guestScreen.dart';
import 'package:okkpd_mobile/pages/login/loginScreen.dart';
import 'package:okkpd_mobile/pages/guest/dashBoardGuestScreen.dart';
import 'package:okkpd_mobile/pages/guest/kontakScreen.dart';

class HomeGuestScreen extends StatefulWidget {
  @override
  _HomeGuestScreen createState() => _HomeGuestScreen();
}

class _HomeGuestScreen extends State<HomeGuestScreen> {
  String appBarTitle = "OKKPD Jateng";

  int selectedIndex = 0;
  final widgetOptions = [
    DashboarGuestScreen(),
    GuestScreen(),
    KontakScreen(),
    LoginScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Color.fromRGBO(0, 0, 0, 87)),
          backgroundColor: Color.fromRGBO(255, 255, 255, 50),
          leading: new Container(),
          title: Text(appBarTitle, style: TextStyle(color: Colors.black87)),
          centerTitle: true,
        ),
        body: Center(
          child: widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Beranda')),
            BottomNavigationBarItem(
                icon: Icon(Icons.perm_media), title: Text('QR')),
            BottomNavigationBarItem(
                icon: Icon(Icons.contact_phone), title: Text('Kontak')),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box), title: Text('Login')),
          ],
          currentIndex: selectedIndex,
          fixedColor: Colors.blue,
          onTap: onItemTapped,
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      if (index == 0) {
        appBarTitle = "Beranda";
      } else if (index == 1) {
        appBarTitle = "QR";
      } else if (index == 2) {
        appBarTitle = "Kontak";
      } else if (index == 3) {
        appBarTitle = "Login";
      }
    });
  }

  static Future<void> pop() async {
    await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
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
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }
}

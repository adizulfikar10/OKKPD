import 'package:flutter/material.dart';
import 'package:okkpd_mobile/model/repository/SharedPrefRepo.dart';
import 'package:okkpd_mobile/model/repository/loginRepo.dart';
import 'package:okkpd_mobile/pages/guest/homeGuestScreen.dart';

class InfoUserWidget extends StatefulWidget {
  @override
  _InfoUserWidgetState createState() => _InfoUserWidgetState();
}

class _InfoUserWidgetState extends State<InfoUserWidget> {
  String namaUser = '';
  String roleUser = '';
  @override
  void initState() {
    super.initState();
    getInformasi();
  }

  void getInformasi() async {
    var namaUser = await SharedPrefRepo().getNamaLengkap();
    var roleUser = await SharedPrefRepo().getNamaRole();
    setState(() {
      this.namaUser = namaUser;
      this.roleUser = roleUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Colors.blueAccent,
      padding: EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 32),
            width: 50,
            height: 50,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.all(new Radius.circular(100.0)),
            ),
            child: IconButton(
              icon: new Icon(Icons.person),
              color: Colors.black,
              onPressed: () {},
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  namaUser,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                child: Text(
                  roleUser,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              MaterialButton(
                  elevation: 3,
                  color: Colors.white,
                  padding: EdgeInsets.all(16),
                  onPressed: () {
                    actionLogout();
                  },
                  child: Container(
                    child: Text("Keluar"),
                  )),
            ],
          )
        ],
      ),
    );
  }

  void actionLogout() async {
    var data = await _onWillPop();
    if (data == true) {
      LoginRepo().logoutProcess();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeGuestScreen()),
      );
    }
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Logout'),
            content: new Text('Apakah anda yakin ingin logout?'),
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
        Future.value(false);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:okkpd_mobile/model/masterLayananModel.dart';

class DashboardLayananWidget extends StatelessWidget {
  const DashboardLayananWidget({Key key, this.layanan}) : super(key: key);
  final MasterLayananModel layanan;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Card(
        color: Colors.white,
        child: new InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(layanan.route);
          },
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Image.asset(layanan.path),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    layanan.namaLayanan,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ]),
        ));
  }
}

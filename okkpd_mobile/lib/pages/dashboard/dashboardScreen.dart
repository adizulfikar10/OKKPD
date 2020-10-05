import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:okkpd_mobile/constants/key.dart';
import 'package:okkpd_mobile/pages/dashboard/beritaWidget.dart';
import 'package:okkpd_mobile/pages/dashboard/dashboarLayananWidget.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

void _portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    return Scaffold(
        body: Container(
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        shrinkWrap: false,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                    color: Color.fromRGBO(239, 239, 239, 100),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16, top: 16),
                            child: Text("Layanan",
                                style: new TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          physics: new NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          padding: EdgeInsets.only(
                              left: 12, top: 16, right: 12, bottom: 12),
                          crossAxisCount: 3,
                          children: List.generate(Keys.layanan.length, (index) {
                            return Center(
                              child: DashboardLayananWidget(
                                layanan: Keys.layanan[index],
                              ),
                            );
                          }),
                        ),
                      ],
                    )),
                Container(
                  child: BeritaWidget("prev"),
                ),
                SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

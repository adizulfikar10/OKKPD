import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';
import 'package:url_launcher/url_launcher.dart';

class KontakScreen extends StatefulWidget {
  @override
  _KontakScreen createState() => _KontakScreen();
}

class _KontakScreen extends State<KontakScreen> {
  _launchURL() async {
    const url =
        'https://api.whatsapp.com/send?phone=6285725260232&text=Halo%20Admin%20Saya%20Mau%20Tanya%20Nih';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          Container(
              color: Color.fromRGBO(239, 239, 239, 100),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text("Kontak",
                          style: new TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                      width: 250,
                      height: 250,
                      child: Image(image: AssetImage('assets/kontak.png'))),
                ],
              )),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 250,
                        child: Text(
                          "KONTAK",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontFamily: "NeoSansBold"),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  child: new Divider(
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.web),
                        tooltip: 'Increase volume by 10',
                        onPressed: () {},
                      ),
                      Container(
                        width: 310,
                        child: Text(
                          "Web : http://okkpd.dishanpan.jatengprov.go.id/",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "NeoSansBold"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Material(
              child: FunctionDart.customButton(
                  context, _launchURL, "Hubungi Admin"),
              // MaterialButton(
              //   minWidth: 200.0,
              //   height: 42.0,
              //   onPressed: _launchURL,
              //   color: Colors.lightBlueAccent,
              //   child: Text('Hubungi Admin',
              //       style: TextStyle(color: Colors.white, fontSize: 20.0)),
              // ),
            ),
          ),
        ],
      ),
    ));
  }
}

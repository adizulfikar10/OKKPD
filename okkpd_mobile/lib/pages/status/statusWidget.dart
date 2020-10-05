import 'package:flutter/material.dart';

class StatusWidget extends StatefulWidget {
  @override
  _StatusWidgetState createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    final track =
        FutureBuilder(builder: (BuildContext context, AsyncSnapshot res) {
      var data = [
        {'Track': 'HC', 'Status': 'Ditolak'},
        {'Track': 'Rumah Kemas', 'Status': 'Diterima'},
        {'Track': 'Rumah Kemas', 'Status': 'Diterima'},
        {'Track': 'Rumah Kemas', 'Status': 'Diterima'},
        {'Track': 'Rumah Kemas', 'Status': 'Diterima'},
        {'Track': 'Rumah Kemas', 'Status': 'Diterima'},
        {'Track': 'Rumah Kemas', 'Status': 'Diterima'},
        {'Track': 'Rumah Kemas', 'Status': 'Diterima'},
        {'Track': 'Rumah Kemas', 'Status': 'Diterima'},
        {'Track': 'Prima 2', 'Status': 'Diterima'},
      ];

      final children = <Widget>[];
      for (var datas in data) {
        children.add(new Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: new InkWell(
            onTap: () {
              print("tapped");
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: queryData.size.width / 3,
                        child: Text(
                          datas['Track'].toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontFamily: "NeoSansBold"),
                        ),
                      ),
                      Container(
                        width: queryData.size.width / 4,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        decoration: new BoxDecoration(
                          color: (datas['Status'].toString() == 'Ditolak')
                              ? Colors.redAccent
                              : Colors.green,
                          borderRadius: new BorderRadius.circular(15.0),
                          border: new Border.all(
                            width: 5.0,
                            color: Colors.transparent,
                          ),
                        ),
                        child: Text(
                          datas['Status'].toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: "NeoSansBold",
                          ),
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
                      Container(
                        width: queryData.size.width / 3,
                        child: Text(
                          "Keteranganya disini",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontFamily: "NeoSansBold"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
      }
      return new Column(
        children: children,
      );
    });

    return ListView(
      children: <Widget>[
        SizedBox(height: 10.0),
        SingleChildScrollView(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(children: <Widget>[
              track,
            ])),
      ],
    );
  }
}

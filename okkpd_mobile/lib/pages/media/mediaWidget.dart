import 'package:flutter/material.dart';
import 'package:okkpd_mobile/model/mediaModel.dart';
import 'package:okkpd_mobile/model/repository/mediaRepo.dart';
import 'package:okkpd_mobile/pages/media/mediaBody.dart';

import '../../tools/CustomWidget.dart';

class MediaWidget extends StatefulWidget {
  @override
  _MediaWidget createState() => _MediaWidget();
}

class _MediaWidget extends State<MediaWidget> {
  final List<MediaModel> model = [];
  bool isLoading = true;

  Future cekDokumen() async {
    var getModel = await MediaRepo().getStatusDokumen();
    setState(() {
      this.model.addAll(getModel);
    });
    if (model.length > 0) {
      isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    cekDokumen();
  }

  Widget isChecked(String status) {
    if (status == '1') {
      return Icon(Icons.check, color: Colors.green);
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    final track =
        FutureBuilder(builder: (BuildContext context, AsyncSnapshot res) {
      final children = <Widget>[];
      for (var datas in model) {
        children.add(new Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: new InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MediaBody(datas.namaDokumen, datas.kodeDokumen)),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: queryData.size.width / 1.5,
                        height: 30,
                        child: Text(
                          datas.namaDokumen,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontFamily: "NeoSansBold"),
                        ),
                      ),
                      Container(
                        width: queryData.size.width / 10,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: isChecked(datas.sudahAda),
                      )
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
    return (isLoading)
        ? CustomWidget().loadingWidget()
        : ListView(
            children: <Widget>[
              SingleChildScrollView(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(children: <Widget>[
                    SizedBox(height: 24.0),
                    track,
                  ])),
            ],
          );
  }
}

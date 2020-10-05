import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:okkpd_mobile/model/mediaModel.dart';
import 'package:okkpd_mobile/model/repository/mediaRepo.dart';
import 'package:okkpd_mobile/pages/modal/modalImagePage.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../tools/CustomWidget.dart';

class MediaBodyWidget extends StatefulWidget {
  String id;
  MediaBodyWidget(this.id);
  @override
  _MediaBodyWidget createState() => _MediaBodyWidget(id);
}

class _MediaBodyWidget extends State<MediaBodyWidget> {
  String id;
  _MediaBodyWidget(this.id);
  static const String View = 'View';
  static const String Delete = 'Delete';

  static const List<String> choices = <String>[View, Delete];

  final List<MediaModel> model = [];

  ProgressDialog pr;

  bool isLoading = true;
  bool isHaveData = false;

  Future cekDokumen() async {
    this.model.clear();
    var getModel = await MediaRepo().getMediaById(this.id);
    setState(() {
      isLoading = false;
      if (getModel != null) {
        this.model.addAll(getModel);
        isHaveData = true;
      }
    });
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

  void choiceAction(String choice) {
    var res = choice.split('~');

    if (res[0] == 'Delete') {
      deleteMedia(res[1]);
    } else {}
  }

  void deleteMedia(String id) async {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    try {
      pr.show();
      bool isSuccess = true;
      this.cekDokumen();
      isSuccess = await MediaRepo().deleteMedia(id);
      if (isSuccess) {
        setState(() {
          this.isLoading = true;
        });
        FunctionDart().setToast("Dokumen berhasil dihapus");
      } else {
        FunctionDart().setToast("Dokumen gagal");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      pr.dismiss();
    }
  }

  void showImage(url) {
    if (url != '') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ModalImagePage(url)),
      );
    }
  }

  Widget dataMedia(FutureBuilder track) {
    if (isLoading) {
      return CustomWidget().loadingWidget();
    } else {
      if (isHaveData) {
        return ListView(
          children: <Widget>[
            SingleChildScrollView(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(children: <Widget>[
                  SizedBox(height: 24.0),
                  track,
                ])
            ),
          ],
        );
      } else {
        return Text("Tidak ada media");
      }
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
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(18.0, 1.0, 1.0, 1.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          datas.namaMedia.length > 15 ? Text(
                              datas.namaMedia.substring(0, 15) +
                                  '...    ' +
                                  datas.dateUpload,
                              style: new TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)
                          ): Text(
                              datas.namaMedia + " " +
                                  datas.dateUpload,
                              style: new TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          Container(
                            width: queryData.size.width / 10,
                            alignment: Alignment.topRight,
                            child: Transform.rotate(
                                angle: 1.55,
                                origin: Offset(0.0, 0.0),
                                child: PopupMenuButton<String>(
                                  onSelected: choiceAction,
                                  itemBuilder: (BuildContext context) {
                                    return choices.map((String choice) {
                                      return PopupMenuItem<String>(
                                        value: choice + '~' + datas.idMedia,
                                        child: Text(choice),
                                      );
                                    }).toList();
                                  },
                                )),
                          )
                        ])),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        child: FlatButton(
                          onPressed: () =>
                              showImage(datas.folder + datas.namaMedia),
                          padding: EdgeInsets.all(0.0),
                          child: Image.network(
                            datas.folder + datas.namaMedia,
                            fit: BoxFit.fill,
                          ),
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

    return dataMedia(track);
  }
}

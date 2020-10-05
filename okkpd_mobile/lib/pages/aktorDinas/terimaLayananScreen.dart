import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:okkpd_mobile/constants/key.dart';
import 'package:okkpd_mobile/model/dokumenModel.dart';
import 'package:okkpd_mobile/model/layananModel.dart';
import 'package:okkpd_mobile/model/repository/layananRepo.dart';
import 'package:okkpd_mobile/model/repository/mediaRepo.dart';
import 'package:okkpd_mobile/pages/aktorDinas/tolakLayananScreen.dart';
import 'package:okkpd_mobile/pages/modal/modalImagePage.dart';
import 'package:okkpd_mobile/tools/CustomWidget.dart';
import 'package:progress_dialog/progress_dialog.dart';

class TerimaLayananScreen extends StatefulWidget {
  final LayananModel layanan;

  TerimaLayananScreen(this.layanan);

  @override
  _TerimaLayananScreenState createState() =>
      _TerimaLayananScreenState(this.layanan);
}

void _portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class _TerimaLayananScreenState extends State<TerimaLayananScreen> {
  ProgressDialog pr;
  final LayananModel layanan;

  List listDokumen = [];
  final List<DokumenModel> dokumens = [];

  var isLoading = true;
  var haveData = true;

  _TerimaLayananScreenState(this.layanan);

  @override
  void initState() {
    super.initState();
    getUploadedMedia();
  }

  void showImage(url) {
    if (url != '') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ModalImagePage(url)),
      );
    }
  }

  void getUploadedMedia() async {
    listDokumen = await MediaRepo().getUploadedMedia(layanan.uid);
    setState(() {
      dokumens.clear();
      if (listDokumen != null) {
        haveData = true;
        for (var datas in listDokumen) {
          dokumens.add(datas);
        }
      } else {
        haveData = false;
      }
      isLoading = false;
    });
  }

  Widget cardDokumen(DokumenModel dokumen, int index) {
    return Card(
        color: Colors.grey,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: dokumen.file != ""
                  ? Center(
                      child: CachedNetworkImage(
                        imageUrl: dokumen.folder + dokumen.file,
                        imageBuilder: (context, imageProvider) => FlatButton(
                          onPressed: () {
                            if (dokumen.folder != "") {
                              showImage(dokumen.folder + dokumen.file);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.red, BlendMode.colorBurn)),
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            CustomWidget().imageError(),
                        fit: BoxFit.fill,
                      ),
                    )
                  : CustomWidget().imageError(),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                dokumen.namaDokumen,
                style: Keys().normalFontSize,
              ),
            )
          ],
        ));
  }

  Widget createView() {
    if (isLoading) {
      return CustomWidget().loadingWidget();
    } else {
      if (haveData) {
        return Container(
          margin: EdgeInsets.only(bottom: 48),
          child: GridView.count(
            shrinkWrap: false,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            padding: EdgeInsets.only(left: 12, top: 16, right: 12, bottom: 12),
            crossAxisCount: 2,
            children: List.generate(dokumens.length, (index) {
              return cardDokumen(dokumens[index], index);
            }),
          ),
        );
      } else {
        return Text("Tidak Ada Data");
      }
    }
  }

  Future<bool> dialogTerima() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Terima Dokumen'),
            content: new Text('Apakah anda yakin untuk menerima layanan ini?'),
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

  void terimaDokumen() async {
    if (await dialogTerima()) {
      pr.show();
      if (await LayananRepo().terimaLayanan(layanan.uid)) {
        Navigator.pop(context);
        Navigator.pop(context);
      }
    }
  }

  Widget buttonTerimaTolak() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Material(
            child: MaterialButton(
              height: 42.0,
              onPressed: () {
                terimaDokumen();
              },
              color: Colors.lightBlueAccent,
              child: Text('Terima', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        Expanded(
          child: Material(
            child: MaterialButton(
              height: 42.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TolakLayananScreen(layanan)),
                );
              },
              color: Colors.amberAccent,
              child: Text('Tolak', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true);

    _portraitModeOnly();
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Dokumen    "),
      ),
      body: Container(
        child: createView(),
      ),
      bottomSheet: buttonTerimaTolak(),
    );
  }
}

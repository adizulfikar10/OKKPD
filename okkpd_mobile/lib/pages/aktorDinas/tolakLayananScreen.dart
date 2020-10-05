import 'package:flutter/material.dart';
import 'package:okkpd_mobile/constants/key.dart';
import 'package:okkpd_mobile/model/layananModel.dart';
import 'package:okkpd_mobile/model/repository/layananRepo.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';
import 'package:progress_dialog/progress_dialog.dart';

ProgressDialog pr;

class TolakLayananScreen extends StatefulWidget {
  LayananModel layanan;
  TolakLayananScreen(this.layanan);

  @override
  _TolakLayananScreenState createState() =>
      _TolakLayananScreenState(this.layanan);
}

class _TolakLayananScreenState extends State<TolakLayananScreen> {
  LayananModel layanan;
  var _alasanController = TextEditingController();

  _TolakLayananScreenState(this.layanan);

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: FunctionDart.setAppBar("Tolak Layanan"),
        body: viewTolak());
  }

  void tolakLayanan() async {
    if (_alasanController.text.isEmpty) {
      FunctionDart().setToast("Alasan masih kosong");
    } else {
      pr.show();
      if (await LayananRepo()
          .tolakLayanan(layanan.uid, _alasanController.text)) {
        Navigator.pop(context);
        Navigator.pop(context);
      }
    }
  }

  Widget viewTolak() {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      shrinkWrap: false,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "${layanan.namaLayanan}",
                          style: Keys().bigBoldFontSiza,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text("Nama Usaha : ${layanan.namaUsaha}"),
                        SizedBox(
                          height: 8,
                        ),
                        Text("Kode Pendaftaran : ${layanan.kodePendaftaran}"),
                        SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Alasan Penolakan",
                        style: Keys().smallFontSize,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: new BoxDecoration(
                          color: Color.fromRGBO(230, 234, 237, 100),
                          border:
                              new Border.all(color: Colors.grey, width: 0.0),
                          borderRadius: new BorderRadius.circular(4.0)),
                      child: TextField(
                        controller: _alasanController,
                        decoration: new InputDecoration.collapsed(
                            border: InputBorder.none,
                            hintText: 'Alasan Penolakan'),
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Material(
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 42.0,
                        onPressed: () {
                          tolakLayanan();
                        },
                        color: Colors.lightBlueAccent,
                        child: Text('Tolak',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: new Text(
                          "Batal",
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

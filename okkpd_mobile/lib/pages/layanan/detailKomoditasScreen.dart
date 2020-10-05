import 'package:flutter/material.dart';
import 'package:okkpd_mobile/model/komoditasModel.dart';
import 'package:okkpd_mobile/model/repository/komoditasRepo.dart';
import 'package:okkpd_mobile/pages/homeScreen.dart';
import 'package:okkpd_mobile/pages/layanan/tambah/tambahKomoditasScreen.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';
import 'package:progress_dialog/progress_dialog.dart';

class DetailKomoditasScreen extends StatefulWidget {
  final String jenis;
  DetailKomoditasScreen(this.jenis);

  @override
  _DetailKomoditasScreen createState() => _DetailKomoditasScreen(jenis);
}

class _DetailKomoditasScreen extends State<DetailKomoditasScreen> {
  final String jenis;
  _DetailKomoditasScreen(this.jenis);

  final List<KomoditasModel> komoditases = [];
  final _normalFont = const TextStyle(fontSize: 14.0);
  final _smallFont = const TextStyle(fontSize: 12.0);
  ProgressDialog pr;

  @override
  void initState() {
    super.initState();
  }

  void simpanKomoditas() async {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    try {
      pr.show();
      await KomoditasRepo().postKomoditas(komoditases, jenis);
    } catch (e) {
      print("Error Insert");
    } finally {
      pr.dismiss();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen('1')),
      );
    }
  }

  void _addKomoditas(KomoditasModel kmd) {
    setState(() {
      if (kmd != null) {
        komoditases.add(kmd);
      }
    });
  }

  void _removeKomoditas(int i) {
    setState(() {
      komoditases.removeAt(i);
    });
  }

  void _showMaterialDialog(int i) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Hapus Komoditas'),
            content: Text('Anda yakin untuk menghapus komoditas ini?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    _dismissDialog();
                  },
                  child: Text('Tidak')),
              FlatButton(
                onPressed: () {
                  _removeKomoditas(i);
                  _dismissDialog();
                },
                child: Text('Ya'),
              )
            ],
          );
        });
  }

  _dismissDialog() {
    Navigator.pop(context);
  }

  _buildSuggestions() {
    return ListView.builder(
        itemCount: komoditases.length,
        itemBuilder: (context, i) {
          return _buildRow(komoditases[i], i);
        });
  }

  _buildRow(KomoditasModel komoditas, int i) {
    return ListTile(
        title: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                komoditas.deskripsi,
                style: _normalFont,
              ),
            ),
            SizedBox(height: 8.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${komoditas.luasLahan} Ha",
                style: _smallFont,
              ),
            ),
            Divider(
              height: 1,
              color: Colors.black,
            ),
          ],
        ),
        trailing: RaisedButton(
          color: Colors.redAccent,
          onPressed: () {
            _showMaterialDialog(i);
          },
          child: Icon(
            Icons.remove,
            color: Colors.white,
            size: 36,
          ),
        ));
  }

  _tambahKomoditas(BuildContext context) async {
    final KomoditasModel result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TambahKomoditasScreen()),
    );
    _addKomoditas(result);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Komoditas dan Lahan",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontFamily: "NeoSansBold"),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                        color: Colors.greenAccent,
                        onPressed: () {
                          _tambahKomoditas(context);
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 28,
                        ),
                      )),
                ],
              )),
          Expanded(child: _buildSuggestions()),
          Padding(
            padding: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 0.0, bottom: 20.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              minWidth: queryData.size.width,
              height: queryData.size.height / 13,
              onPressed: () {
                if (komoditases.length != 0) {
                  simpanKomoditas();
                } else {
                  FunctionDart().setToast('Komoditas Tidak Boleh Kosong');
                }
              },
              color: Color(0xff2ECC71),
              child: Text('Simpan', style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}

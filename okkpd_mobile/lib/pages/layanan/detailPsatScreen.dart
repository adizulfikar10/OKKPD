import 'package:flutter/material.dart';
import 'package:okkpd_mobile/model/produkModel.dart';
import 'package:okkpd_mobile/model/repository/produkRepo.dart';
import 'package:okkpd_mobile/pages/layanan/tambah/tambahProdukScreen.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../homeScreen.dart';

class DetailPsatScreen extends StatefulWidget {
  final String jenis;
  DetailPsatScreen(this.jenis);

  @override
  _DetailPsatScreen createState() => _DetailPsatScreen(jenis);
}

class _DetailPsatScreen extends State<DetailPsatScreen> {
  final String jenis;
  _DetailPsatScreen(this.jenis);

  final List<ProdukModel> produks = [];
  final _normalFont = const TextStyle(fontSize: 14.0);
  final _smallFont = const TextStyle(fontSize: 12.0);
  ProgressDialog pr;

  @override
  void initState() {
    super.initState();
  }

  void simpanProduk() async {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    try {
      pr.show();
      await ProdukRepo().postProduk(produks, jenis);
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

  void _addProduk(ProdukModel prd) {
    setState(() {
      if (prd != null) {
        produks.add(prd);
      }
    });
  }

  void _removeProduk(int i) {
    setState(() {
      produks.removeAt(i);
    });
  }

  void _showMaterialDialog(int i) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Hapus Produk'),
            content: Text('Anda yakin untuk menghapus Produk ini?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    _dismissDialog();
                  },
                  child: Text('Tidak')),
              FlatButton(
                onPressed: () {
                  _removeProduk(i);
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
        itemCount: produks.length,
        itemBuilder: (context, i) {
          return _buildRow(produks[i], i);
        });
  }

  _buildRow(ProdukModel psat, int i) {
    return ListTile(
        title: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                psat.namaProdukPangan,
                style: _normalFont,
              ),
            ),
            SizedBox(height: 8.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                // "${Psat.luasLahan} Ha",
                '',
                style: _smallFont,
              ),
            )
          ],
        ),
        trailing: RaisedButton(
          onPressed: () {
            _showMaterialDialog(i);
          },
          child: Icon(
            Icons.remove,
            color: Colors.blueAccent,
            size: 36,
          ),
        ));
  }

  _tambahProduk(BuildContext context) async {
    final ProdukModel result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TambahProdukScreen()),
    );
    _addProduk(result);
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
                    "Produk dan Lahan",
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
                          _tambahProduk(context);
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
                if (produks.length != 0) {
                  simpanProduk();
                } else {
                  FunctionDart().setToast('Produk Tidak Boleh Kosong');
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

import 'package:flutter/material.dart';
import 'package:okkpd_mobile/model/produkModel.dart';
import 'package:okkpd_mobile/model/repository/produkRepo.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';
import 'package:progress_dialog/progress_dialog.dart';

class TambahProdukScreen extends StatefulWidget {
  @override
  _TambahProdukScreen createState() => _TambahProdukScreen();
}

class _TambahProdukScreen extends State<TambahProdukScreen> {
  ProgressDialog pr;

  var _namaProduk = TextEditingController();
  var _namaDagang = TextEditingController();
  var _jenisKemasan = TextEditingController();
  var _beratBersih = TextEditingController();
  var _satuanKemasan = TextEditingController();

  List<ProdukModel> produk = [];

  void simpanProduk() async {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    try {
      pr.show();
      await ProdukRepo().postProduk(produk, "");
    } catch (e) {
      print("Error Insert");
    } finally {
      pr.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    final beratBersih = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FunctionDart.textFormField(
              _beratBersih, TextInputType.number, 'Berat Bersih')
        ]);

    final jenisKemasan = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FunctionDart.textFormField(
              _jenisKemasan, TextInputType.text, 'Jenis Kemasan')
        ]);

    final namaDagang =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      FunctionDart.textFormField(_namaDagang, TextInputType.text, 'Nama Dagang')
    ]);

    final namaProduk =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      FunctionDart.textFormField(_namaProduk, TextInputType.text, 'Nama Produk')
    ]);

    final satuanKemasan = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FunctionDart.textFormField(
              _satuanKemasan, TextInputType.text, 'Satuan Kemasan')
        ]);

    Future addItem() async {
      ProdukModel exp = ProdukModel(
          null,
          null,
          null,
          _jenisKemasan.text,
          null,
          _namaDagang.text,
          _namaProduk.text,
          _beratBersih.text,
          _satuanKemasan.text,
          null,
          null);
      if (exp == null) {
        FunctionDart().setToast('Data Form Pendaftaran Tidak Lengkap');
      } else {
        Navigator.pop(context, exp);
      }
    }

    final saveButton = FunctionDart.saveButton(context, addItem);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: FunctionDart.setAppBar("Pendaftaran Produk"),
      body: Padding(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 16.0),
            namaProduk,
            SizedBox(height: 16.0),
            namaDagang,
            SizedBox(height: 16.0),
            jenisKemasan,
            SizedBox(height: 16.0),
            beratBersih,
            SizedBox(height: 16.0),
            satuanKemasan,
            Padding(padding: EdgeInsets.only(top: queryData.size.height / 4)),
            saveButton,
          ],
        ),
      ),
    );
  }
}

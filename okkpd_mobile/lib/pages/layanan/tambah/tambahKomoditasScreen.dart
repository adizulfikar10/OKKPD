import 'package:flutter/material.dart';
import 'package:okkpd_mobile/model/komoditasModel.dart';
import 'package:okkpd_mobile/model/repository/komoditasRepo.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';
import 'package:progress_dialog/progress_dialog.dart';

class TambahKomoditasScreen extends StatefulWidget {
  @override
  _TambahKomoditasScreen createState() => _TambahKomoditasScreen();
}

class _TambahKomoditasScreen extends State<TambahKomoditasScreen> {
  ProgressDialog pr;

  var _namaKomoditas = TextEditingController();
  var _luasLahan = TextEditingController();

  List getSektor = [];
  List getKelompok = [];
  List getKomoditas = [];
  List sektor = [];
  List kelompok = [];
  List komoditas = [];
  String idSektor;
  String idKelompok;
  String idKomoditas;
  String namaLatin;
  String nmKomoditas;

  Future getDataSektor() async {
    try {
      getSektor = await KomoditasRepo().getSektor();
      sektor.clear();
      komoditas.clear();
      kelompok.clear();
      setState(() {
        for (var datas in getSektor) {
          sektor.add(datas);
        }
      });
    } catch (e) {
      FunctionDart().setToast('Belum Ada Komoditas');
    }
  }

  Future getDataKelompok(String idSektor) async {
    try {
      getKelompok = await KomoditasRepo().getKelompok(idSektor);
      if (getKelompok != null) {
        setState(() {
          komoditas.clear();
          kelompok.clear();

          idKomoditas = null;
          idKelompok = null;
          for (var datas in getKelompok) {
            kelompok.add(datas);
          }
        });
      } else {
        var datas = {'idKelompok': 0, 'namaKelompok': 'Nama Kelompok'};
        kelompok.add(datas);
      }
    } catch (e) {
      FunctionDart().setToast('Belum Ada Kelompok Dalam Sektor');
    }
  }

  Future getDataKomoditas(String idSektor, String idKelompok) async {
    try {
      getKomoditas = await KomoditasRepo().getKomoditas(idSektor, idKelompok);
      if (getKomoditas != null) {
        setState(() {
          komoditas.clear();
          idKomoditas = null;
          for (var datas in getKomoditas) {
            komoditas.add(datas);
          }
        });
      } else {
        FunctionDart().setToast('Belum Ada Komoditas Dalam Kelompok');
      }
    } catch (e) {
      FunctionDart().setToast('Belum Ada Komoditas Dalam Kelompok');
    }
  }

  Future setInit() async {
    await getDataSektor();
  }

  void simpanKomoditas() async {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    try {
      pr.show();
      await KomoditasRepo().postKomoditas(komoditas, "prima_3");
    } catch (e) {
      print("Error Insert");
    } finally {
      _luasLahan.text = "";
      _namaKomoditas.text = "";
      pr.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
    setInit();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    final namaKomoditas =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: 'Nama Komoditas',
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(8.0),
            borderSide: new BorderSide(),
          ),
        ),
        items: komoditas.map((value) {
          return new DropdownMenuItem(
            child: new Text(value.deskripsi),
            value: value.idKomoditas.toString(),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            idKomoditas = value;
            for (var kmd in komoditas) {
              if (kmd.idKomoditas == idKomoditas) {
                namaLatin = kmd.namaLatin;
                nmKomoditas = kmd.deskripsi;
              }
            }
          });
        },
        value: idKomoditas ?? null,
      ),
    ]);

    final namaSektor =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: 'Nama Sektor',
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(8.0),
            borderSide: new BorderSide(),
          ),
        ),
        items: sektor.map((value) {
          return new DropdownMenuItem(
            child: new Text(value.namaSektorKomoditas),
            value: value.idSektor.toString(),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            idSektor = value;
            getDataKelompok(idSektor);
          });
        },
        value: idSektor ?? null,
      ),
    ]);

    final namaKelompok =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: 'Nama Kelompok',
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(8.0),
            borderSide: new BorderSide(),
          ),
        ),
        items: kelompok.map((value) {
          return new DropdownMenuItem(
            child: new Text(value.namaKelompok),
            value: value.idKelompok.toString(),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            idKelompok = value;
            getDataKomoditas(idSektor, idKelompok);
          });
        },
        value: idKelompok ?? null,
      ),
    ]);

    final luasLahan = FunctionDart.textFormField(
        _luasLahan, TextInputType.number, 'Luas Lahan');
    //     Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
    //   Text(
    //     "Luas Lahan",
    //     textAlign: TextAlign.left,
    //     style: TextStyle(
    //         fontSize: 14, color: Colors.black54, fontFamily: "NeoSansBold"),
    //   ),
    //   TextFormField(
    //     controller: _luasLahan,
    //     keyboardType: TextInputType.text,
    //     autofocus: false,
    //     decoration: InputDecoration(
    //       hintText: '',
    //     ),
    //   ),
    // ]);

    final spasiforjarak =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Text(
        "",
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 14, color: Colors.black54, fontFamily: "NeoSansBold"),
      ),
    ]);

    Future addItem() async {
      KomoditasModel kmd = KomoditasModel(null, nmKomoditas, "", idSektor,
          idKomoditas, idKelompok, _luasLahan.text, nmKomoditas, namaLatin);
      if (idSektor == null ||
          idKomoditas == null ||
          idKelompok == null ||
          _luasLahan.text.length == 0) {
        FunctionDart().setToast('Data Form Pendaftaran Tidak Lengkap');
      } else {
        Navigator.pop(context, kmd);
      }
    }

    final saveButton = FunctionDart.saveButton(context, addItem);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: FunctionDart.setAppBar("Tambah Komoditas"),
      body: Padding(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 16.0),
            namaSektor,
            SizedBox(height: 16.0),
            namaKelompok,
            SizedBox(height: 16.0),
            namaKomoditas,
            SizedBox(height: 16.0),
            luasLahan,
            Spacer(),
            saveButton,
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:okkpd_mobile/model/exportModel.dart';
import 'package:okkpd_mobile/model/repository/exportRepo.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';
import 'package:progress_dialog/progress_dialog.dart';

class TambahExportScreen extends StatefulWidget {
  @override
  _TambahExportScreen createState() => _TambahExportScreen();
}

class _TambahExportScreen extends State<TambahExportScreen> {
  ProgressDialog pr;

  var _namaProduk = TextEditingController();
  var _jenisProduk = TextEditingController();
  var _nomorHs = TextEditingController();
  var _namaExportir = TextEditingController();
  var _alamatKantor = TextEditingController();
  var _alamatGudang = TextEditingController();
  var _consigmentCode = TextEditingController();
  var _jumlahLot = TextEditingController();
  var _beratLot = TextEditingController();
  var _jumlahKemasan = TextEditingController();
  var _jenisKemasan = TextEditingController();
  var _beratKotor = TextEditingController();
  var _beratBersih = TextEditingController();
  var _pelabuhanPemberangkatan = TextEditingController();
  var _identitasTransportasi = TextEditingController();
  var _pelabuhanTujuan = TextEditingController();
  var _negaraTujuan = TextEditingController();
  var _negaraTransit = TextEditingController();
  var _pelabuhanTransit = TextEditingController();
  var _transportasiTransit = TextEditingController();

  List<ExportModel> export = [];

  void simpanExport() async {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    try {
      pr.show();
      await ExportRepo().postExport(export, "");
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

    final alamatGudang = FunctionDart.textFormField(
        _alamatGudang, TextInputType.text, 'Alamat Gudang');

    final alamatKantor = FunctionDart.textFormField(
        _alamatKantor, TextInputType.text, 'Alamat Kantor');

    final beratBersih = FunctionDart.textFormField(
        _beratBersih, TextInputType.number, 'Berat Bersih');

    final beratKotor = FunctionDart.textFormField(
        _beratKotor, TextInputType.number, 'Berat Kotor');

    final beratLot = FunctionDart.textFormField(
        _beratLot, TextInputType.number, 'Berat Lot');

    final consigmentCode = FunctionDart.textFormField(
        _consigmentCode, TextInputType.text, 'Consigment Code');

    final identitasTransportasi = FunctionDart.textFormField(
        _identitasTransportasi, TextInputType.text, 'Identitas Transportasi');

    final jenisKemasan = FunctionDart.textFormField(
        _jenisKemasan, TextInputType.text, 'Jenis Kemasan');

    final jenisProduk = FunctionDart.textFormField(
        _jenisProduk, TextInputType.text, 'Jenis Produk');

    final jumlahKemasan = FunctionDart.textFormField(
        _jumlahKemasan, TextInputType.number, 'Jumlah Kemasan');

    final jumlahLot = FunctionDart.textFormField(
        _jumlahLot, TextInputType.number, 'Jumlah Lot');

    final namaExportir = FunctionDart.textFormField(
        _namaExportir, TextInputType.text, 'Nama Exportir');

    final namaProduk = FunctionDart.textFormField(
        _namaProduk, TextInputType.text, 'Nama Produk');

    final negaraTransit = FunctionDart.textFormField(
        _negaraTransit, TextInputType.text, 'Negara Transit');

    final negaraTujuan = FunctionDart.textFormField(
        _negaraTujuan, TextInputType.text, 'Negara Tujuan');

    final nomorHs =
        FunctionDart.textFormField(_nomorHs, TextInputType.text, 'Nomor HS');

    final pelabuhanPemberangkatan = FunctionDart.textFormField(
        _pelabuhanPemberangkatan,
        TextInputType.text,
        'Pelabuhan Pemberangkatan');

    final pelabuhanTransit = FunctionDart.textFormField(
        _pelabuhanTransit, TextInputType.text, 'Pelabuhan Transit');

    final pelabuhanTujuan = FunctionDart.textFormField(
        _pelabuhanTujuan, TextInputType.text, 'Pelabuhan Tujuan');

    final transportasiTransit = FunctionDart.textFormField(
        _transportasiTransit, TextInputType.text, 'Transportasi Transit');

    Future addItem() async {
      ExportModel exp = ExportModel(
          null,
          null,
          null,
          null,
          _alamatGudang.text,
          _alamatKantor.text,
          _beratBersih.text,
          _beratKotor.text,
          _beratLot.text,
          _consigmentCode.text,
          _identitasTransportasi.text,
          _jenisKemasan.text,
          _jenisProduk.text,
          _jumlahKemasan.text,
          _jumlahLot.text,
          _namaExportir.text,
          _namaProduk.text,
          _negaraTransit.text,
          _negaraTujuan.text,
          _nomorHs.text,
          _pelabuhanPemberangkatan.text,
          _pelabuhanTransit.text,
          _pelabuhanTujuan.text,
          null,
          _transportasiTransit.text);
      if (exp == null) {
        FunctionDart().setToast('Data Form Pendaftaran Tidak Lengkap');
      } else {
        Navigator.pop(context, exp);
      }
    }

    final saveButton = FunctionDart.saveButton(context, addItem);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: FunctionDart.setAppBar("Tambah Export"),
      body: Center(
        child: ListView(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          children: <Widget>[
            SizedBox(height: 16.0),
            namaProduk,
            SizedBox(height: 16.0),
            jenisProduk,
            SizedBox(height: 16.0),
            nomorHs,
            SizedBox(height: 16.0),
            namaExportir,
            SizedBox(height: 16.0),
            alamatKantor,
            SizedBox(height: 16.0),
            alamatGudang,
            SizedBox(height: 16.0),
            consigmentCode,
            SizedBox(height: 16.0),
            jumlahLot,
            SizedBox(height: 16.0),
            beratLot,
            SizedBox(height: 16.0),
            jumlahKemasan,
            SizedBox(height: 16.0),
            jenisKemasan,
            SizedBox(height: 16.0),
            beratKotor,
            SizedBox(height: 16.0),
            beratBersih,
            SizedBox(height: 16.0),
            pelabuhanPemberangkatan,
            SizedBox(height: 16.0),
            identitasTransportasi,
            SizedBox(height: 16.0),
            pelabuhanTujuan,
            SizedBox(height: 16.0),
            negaraTujuan,
            SizedBox(height: 16.0),
            negaraTransit,
            SizedBox(height: 16.0),
            pelabuhanTransit,
            SizedBox(height: 16.0),
            transportasiTransit,
            SizedBox(height: 16.0),
            saveButton
          ],
        ),
      ),
    );
  }
}

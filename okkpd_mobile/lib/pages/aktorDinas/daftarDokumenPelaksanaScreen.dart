

import 'package:flutter/material.dart';
import 'package:okkpd_mobile/model/dokumenInspeksiModel.dart';
import 'package:okkpd_mobile/model/layananModel.dart';
import 'package:okkpd_mobile/model/repository/SharedPrefRepo.dart';
import 'package:okkpd_mobile/model/repository/layananRepo.dart';
import 'package:okkpd_mobile/pages/aktorDinas/uploadDokumenInsScreen.dart';
import 'package:okkpd_mobile/pages/aktorDinas/viewDokumenScreen.dart';
import 'package:okkpd_mobile/tools/CustomWidget.dart';

import '../../tools/GlobalFunction.dart';

class DaftarDokumenPelaksanaScreen extends StatefulWidget {
  final LayananModel layanan;
  DaftarDokumenPelaksanaScreen(this.layanan);

  @override
  _DaftarDokumenPelaksanaScreen createState() => _DaftarDokumenPelaksanaScreen(this.layanan);
}

class _DaftarDokumenPelaksanaScreen extends State<DaftarDokumenPelaksanaScreen> with WidgetsBindingObserver {
  final LayananModel layanan;
  _DaftarDokumenPelaksanaScreen(this.layanan);

  List<DokumenInspeksiModel> dokumens = [];

  String myRole;
  int isNew = 1;
  var isLoading = true;
  var haveData = true;
  bool isComplete = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    getRole();
    getDokumenInspeksi();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('STTAATTEE = $state');
  }

  void getDokumenInspeksi() async{
    List<DokumenInspeksiModel> listDokumen = [];
    listDokumen = await LayananRepo().getDokumenUpload(layanan.uid);
    setState(() {
      dokumens.clear();
      if (listDokumen != null) {
        haveData = true;
        int i = 0;
        for (var datas in listDokumen) {
          dokumens.add(datas);
          if(datas.idHasil != null){
            i++;

          }
        }
        print('datanya : $i');
        if(i==10){
          isComplete = true;
        }
      } else {
        haveData = false;
      }
      isLoading = false;
    });
  }

  void getRole() async{
    String role = await SharedPrefRepo().getRole();
    setState(() {
      myRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FunctionDart.setAppBar("Daftar Dokumen Inspeksi"),
      body: Container(
        margin: EdgeInsets.only(bottom: 48),
        child: Column(
          children: <Widget>[
            Expanded(child: _buildSuggestions()),
          ],
        ),
      ) ,
      bottomSheet:  Container(
        width: double.infinity,
        child: Material(
          child: MaterialButton(
            height: 42.0,
            onPressed: () {
              isComplete == true ? dialogTerima() : FunctionDart().setToast("Harap lengkapi seluruh dokumen");
            },
            color: isComplete == true ? Colors.lightBlueAccent : Colors.grey,
            child: Text('Terima', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget buttonUpload(LayananModel layanan){
    if(myRole == 'pelaksana'){
      return Container(
        width: double.infinity,
        child: Material(
          child: MaterialButton(
            height: 42.0,
            onPressed: () {

            },
            color: Colors.lightBlueAccent,
            child: Text('Lihat Detail',
                style: TextStyle(color: Colors.white)),
          ),
        ),
      );

    }else{
      return Text("");
    }
  }

  Widget buttonDownload(LayananModel layanan){
    if(myRole == 'm_adm'){
      return Container(
        width: double.infinity,
        child: Material(
          child: MaterialButton(
            height: 42.0,
            onPressed: () {

            },
            color: Colors.lightBlueAccent,
            child: Text('Detail Dokumen',
                style: TextStyle(color: Colors.white)),
          ),
        ),
      );
    }else if(myRole == 'pelaksana'){
      return Row(
        children: <Widget>[
          Expanded(
            child: Material(
              child: MaterialButton(
                height: 42.0,
                onPressed: () {
                },
                color: Colors.lightBlueAccent,
                child: Text('Informasi Usaha',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          SizedBox(width: 16,),
          Expanded(
            child: Material(
              child: MaterialButton(
                height: 42.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DaftarDokumenPelaksanaScreen(layanan)),
                  );
                },
                color: Colors.lightBlueAccent,
                child: Text('Dokumen Inspeksi',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      );
    }else{
      return Container(
        width: double.infinity,
        child: Material(
          child: MaterialButton(
            height: 42.0,
            onPressed: () {

            },
            color: Colors.lightBlueAccent,
            child: Text('Informasi Usaha',
                style: TextStyle(color: Colors.white)),
          ),
        ),
      );
    }
  }

  _buildSuggestions() {
    if (isLoading) {
      return CustomWidget().loadingWidget();
    } else {
      if (haveData) {
        return ListView.builder(
            itemCount: dokumens.length,
            itemBuilder: (context, i) {
              return _buildRow(dokumens[i], i);
            });
      } else {
        return Center(
          child: Text("Tidak ada data yang ditampilkan"),
        );
      }
    }
  }

  Widget getGambar(DokumenInspeksiModel dok){
    if(dok.idHasil != null){
      return Material(
        child: MaterialButton(
          height: 42.0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ViewDokumenScreen(dok.idLayanan, dok.idGambar)),
            );
          },
          color: Colors.white,
          child: Icon(
            Icons.remove_red_eye,
            semanticLabel: 'Text to announce in accessibility modes',
          ),
        ),
      );
    }else {

      return Text("");
    }

  }

  _buildRow(DokumenInspeksiModel dokumen, int i) {
    return ListTile(
        title: Card(
            elevation: 2,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 100,
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    color: Colors.grey,
                    child: Image(image: AssetImage("assets/picture.png"),),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            dokumen.keterangan,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            softWrap: true,
                          ),
                        ),

                        SizedBox(height: 16,),
                        Row(children: <Widget>[
                          Material(
                            child: MaterialButton(
                              height: 42.0,
                              onPressed: () {
                                if(dokumen.idHasil != null){
                                  isNew = 0;
                                }
                                print('DATANYA3 : ${dokumen.idGambar}, $isNew');

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UploadDokumenInsScreen(layanan.uid,dokumen.idGambar,dokumen.keterangan,isNew)),
                                );
                              },
                              color: Colors.lightBlueAccent,
                              child: Text('Unggah',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          SizedBox(width: 8,),
                          getGambar(dokumen)
                        ],)
                      ],
                    ),
                  )
//                      Expanded(
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text(
//                              dokumen.keterangan,
//                              style: TextStyle(
//                                  fontSize: 16, fontWeight: FontWeight.bold),
//                            ),
//                            SizedBox(height: 16.0),
//                          ],
//                        ),
//                      ),



                ],
              ),
            )));
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
            onPressed: () {
              terimaDokumen();
            },
            child: new Text('Ya'),
          ),
        ],
      ),
    ) ??
        false;
  }
  void terimaDokumen() async{
    var data = await LayananRepo().simpanDokumenInspeksi(layanan.uid);
    if(data == true){
      Navigator.pop(context);
      Navigator.pop(context);
    }else{

    }

  }
}

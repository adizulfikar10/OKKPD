import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:okkpd_mobile/model/repository/layananRepo.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';
import 'package:progress_dialog/progress_dialog.dart';

class UploadDokumenInsScreen extends StatefulWidget {
  final String idGambar;
  final String idLayanan;
  final String nama;
  final int isNew;
  UploadDokumenInsScreen(this.idLayanan, this.idGambar, this.nama, this.isNew);

  @override
  _UploadDokumenInsScreen createState() =>
      _UploadDokumenInsScreen(idLayanan, idGambar, nama, isNew);
}

class _UploadDokumenInsScreen extends State<UploadDokumenInsScreen> {
  final String idGambar;
  final String idLayanan;
  final String nama;
  final int isNew;
  _UploadDokumenInsScreen(this.idLayanan, this.idGambar, this.nama, this.isNew);

  ProgressDialog pr;

  File _imageFile;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();

  }

  void _getImage(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = image;
    });
    Navigator.pop(context);
  }

  Future<bool> _uploadImage(File image) async {


    Future<bool> result =
        LayananRepo().uploadDokumenInspeksi(image, idLayanan, idGambar, isNew);

    _resetState();
    return await result;
  }

  void _startUploading() async {
    setState(() {
      _isUploading = true;
    });

    bool result = await _uploadImage(_imageFile);
    if (result == true) {
      FunctionDart().setToast("Dokumen berhasil diunggah");
      _resetState();
      pr.dismiss();
      Navigator.pop(context, true);
    } else {
      _resetState();
      pr.dismiss();
      FunctionDart().setToast("Dokumen gagal diunggah");
    }
  }

  void _resetState() {
    setState(() {
      _isUploading = false;
      _imageFile = null;
    });
  }

  void _openImagePickerModal(BuildContext context) {
    final flatButtonColor = Theme.of(context).primaryColor;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Use Camera'),
                  onPressed: () {
                    _getImage(context, ImageSource.camera);
                  },
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Use Gallery'),
                  onPressed: () {
                    _getImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget _buildUploadBtn() {
    Widget btnWidget = Container();
    if (_isUploading) {
      btnWidget = Container(
          margin: EdgeInsets.only(top: 10.0),
          child: CircularProgressIndicator());
    } else if (!_isUploading && _imageFile != null) {
      btnWidget = Container(
        margin: EdgeInsets.only(top: 10.0),
        child: RaisedButton(
          child: Text('Unggah'),
          onPressed: () {
            pr.show();
            _startUploading();
          },
          color: Colors.pinkAccent,
          textColor: Colors.white,
        ),
      );
    }
    return btnWidget;
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    if(_isUploading){
      print('jahsdkjashdkjashd');
      pr.show();
    }

    return Scaffold(
      appBar: FunctionDart.setAppBar("Unggah Gambar $nama"),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
            child: OutlineButton(
              onPressed: () => _openImagePickerModal(context),
              borderSide:
                  BorderSide(color: Theme.of(context).accentColor, width: 1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.camera_alt),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text('Tambah Dokumen'),
                ],
              ),
            ),
          ),
          _imageFile == null
              ? Text('Pilih gambar')
              : Image.file(
                  _imageFile,
                  fit: BoxFit.cover,
                  height: 300.0,
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width,
                ),
          _buildUploadBtn(),
        ],
      ),
    );
  }
}

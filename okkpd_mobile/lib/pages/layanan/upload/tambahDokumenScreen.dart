import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:okkpd_mobile/model/repository/mediaRepo.dart';
import 'package:okkpd_mobile/tools/CustomWidget.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';
import 'package:file_picker/file_picker.dart';

class TambahDokumenScreen extends StatefulWidget {
  final String kodeDokumen;

  const TambahDokumenScreen(this.kodeDokumen);

  @override
  _TambahDokumenScreen createState() => _TambahDokumenScreen(kodeDokumen);
}

class _TambahDokumenScreen extends State<TambahDokumenScreen> {
  final String kodeDokumen;
  _TambahDokumenScreen(this.kodeDokumen);

  File _imageFile;
  File _pdfFile;
  bool _isUploading = false;

  void _getImage(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = image;
    });
    Navigator.pop(context);
  }

  Future<bool> _uploadImage(File image) async {
    setState(() {
      _isUploading = true;
    });

    Future<bool> result = MediaRepo().uploadMedia(image, kodeDokumen);

    _resetState();
    return await result;
  }

  void _startUploading() async {
    bool result;
    setState(() {
      _isUploading = true;
    });
    if (_pdfFile != null) {
      result = await _uploadImage(_pdfFile);
    } else {
      result = await _uploadImage(_imageFile);
    }
    if (result == true) {
      _resetState();
      FunctionDart().setToast("Dokumen berhasil diunggah");
      Navigator.pop(context, true);
      _isUploading = false;
    } else {
      _resetState();
      FunctionDart().setToast("Dokumen gagal diunggah");
      _isUploading = false;
    }
  }

  void _resetState() {
    setState(() {
      _isUploading = false;
      _imageFile = null;
      _pdfFile = null;
    });
  }

  Future _openFilePdf(BuildContext context) async {
    _pdfFile = await FilePicker.getFile();
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
          child: Text('Upload'),
          onPressed: () {
            _startUploading();
          },
          color: Colors.pinkAccent,
          textColor: Colors.white,
        ),
      );
    } else if (!_isUploading && _pdfFile != null) {
      btnWidget = Container(
        margin: EdgeInsets.only(top: 10.0),
        child: RaisedButton(
          child: Text('Upload'),
          onPressed: () {
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
    return Scaffold(
      appBar: FunctionDart.setAppBar("Image Upload"),
      body: (_isUploading)
          ? CustomWidget().loadingWidget()
          : Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: OutlineButton(
                          onPressed: () => _openImagePickerModal(context),
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 1.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.camera_alt),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('Add Image'),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: OutlineButton(
                          onPressed: () => _openFilePdf(context),
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 1.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.attach_file),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('Add File'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _imageFile == null
                    ? Text('Please pick file')
                    : Image.file(
                        _imageFile,
                        fit: BoxFit.cover,
                        height: 300.0,
                        alignment: Alignment.topCenter,
                        width: MediaQuery.of(context).size.width,
                      ),
                _pdfFile == null ? Text('') : Text(_pdfFile.path),
                _buildUploadBtn(),
              ],
            ),
    );
  }
}

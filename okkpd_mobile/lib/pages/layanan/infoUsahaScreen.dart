import 'package:flutter/material.dart';
import 'package:okkpd_mobile/model/repository/SharedPrefRepo.dart';
import 'package:okkpd_mobile/model/repository/userRepo.dart';
import 'package:okkpd_mobile/model/userModel.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../tools/CustomWidget.dart';

class InfoUsahaScreen extends StatefulWidget {
  final String idUSer;
  InfoUsahaScreen(this.idUSer);

  @override
  _InfoUsahaScreen createState() => _InfoUsahaScreen(this.idUSer);
}

class _InfoUsahaScreen extends State<InfoUsahaScreen> {
  ProgressDialog pr;
  String namaUsaha = "-";
  String alamatUsaha = "-";
  String namaPemohon = "-";
  String idUser = "";

  var isLoading = true;

  _InfoUsahaScreen(this.idUser);

  @override
  void initState() {
    super.initState();
    setUser();
  }

  Future setUser() async {
    if(await SharedPrefRepo().getRole() == 'pelaku'){
      idUser = await SharedPrefRepo().getIdUser();
    }
    UserModel user = await UserRepo().getProfile(idUser);
    if (user != null) {
      setState(() {
        namaUsaha = user.namaUsaha;
        alamatUsaha = user.alamatLengkap;
        namaPemohon = user.namaLengkap;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      color: Color(0xffFBFBFB),
      child: (isLoading)
          ? CustomWidget().loadingWidget()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Informasi Usaha",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontFamily: "NeoSansBold"),
                ),
                SizedBox(height: 24.0),
                TextDetailWidget(
                  title: "Informasi Usaha",
                  content: "$namaUsaha",
                ),
                TextDetailWidget(
                  title: "Alamat",
                  content: "$alamatUsaha",
                ),
                TextDetailWidget(
                  title: "Nama Pemohon",
                  content: "$namaPemohon",
                ),
                Divider(
                  color: Colors.white10,
                ),
              ],
            ),
    );
  }
}

class TextDetailWidget extends StatelessWidget {
  const TextDetailWidget({Key key, this.title, this.content}) : super(key: key);
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "$title",
          style: TextStyle(
              fontSize: 12, color: Colors.black45, fontFamily: "NeoSansBold"),
        ),
        SizedBox(height: 8.0),
        Text(
          "$content",
          style: TextStyle(
              fontSize: 14, color: Colors.black, fontFamily: "NeoSansBold"),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}

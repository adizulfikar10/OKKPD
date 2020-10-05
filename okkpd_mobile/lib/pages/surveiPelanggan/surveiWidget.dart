import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';

class SurveiWidget extends StatefulWidget {
  @override
  _SurveiWidget createState() => _SurveiWidget();
}

class _SurveiWidget extends State<SurveiWidget> {
  List tampilanRate = [
    {'id': 1, 'sts': 'Sangat tidak setuju', 'active': false},
    {'id': 2, 'ts': 'Tidak Setuju', 'active': false},
    {'id': 3, 'n': 'Netral', 'active': false},
    {'id': 4, 's': 'Setuju', 'active': false},
    {'id': 5, 'ss': 'Sangat Setuju', 'active': false}
  ];

  List kecepatanRate = [
    {'id': 1, 'sts': 'Sangat tidak setuju', 'active': false},
    {'id': 2, 'ts': 'Tidak Setuju', 'active': false},
    {'id': 3, 'n': 'Netral', 'active': false},
    {'id': 4, 's': 'Setuju', 'active': false},
    {'id': 5, 'ss': 'Sangat Setuju', 'active': false}
  ];

  List kemudahanRate = [
    {'id': 1, 'sts': 'Sangat tidak setuju', 'active': false},
    {'id': 2, 'ts': 'Tidak Setuju', 'active': false},
    {'id': 3, 'n': 'Netral', 'active': false},
    {'id': 4, 's': 'Setuju', 'active': false},
    {'id': 5, 'ss': 'Sangat Setuju', 'active': false}
  ];

  List kelengkapanRate = [
    {'id': 1, 'sts': 'Sangat tidak setuju', 'active': false},
    {'id': 2, 'ts': 'Tidak Setuju', 'active': false},
    {'id': 3, 'n': 'Netral', 'active': false},
    {'id': 4, 's': 'Setuju', 'active': false},
    {'id': 5, 'ss': 'Sangat Setuju', 'active': false}
  ];

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    _tampilanStar(int i) {
      return IconButton(
        color: Colors.orange,
        icon: tampilanRate[i - 1]['active'] == true
            ? Icon(Icons.star)
            : Icon(Icons.star_border),
        onPressed: () {
          for (var a = 0; a < tampilanRate.length; a++) {
            if (a < i) {
              print(a);
              tampilanRate[a]['active'] = true;
            } else {
              tampilanRate[a]['active'] = false;
            }
          }
          setState(() {});
        },
      );
    }

    _kemudahanStar(int i) {
      return IconButton(
        color: Colors.orange,
        icon: kemudahanRate[i - 1]['active'] == true
            ? Icon(Icons.star)
            : Icon(Icons.star_border),
        onPressed: () {
          for (var a = 0; a < kemudahanRate.length; a++) {
            if (a < i) {
              print(a);
              kemudahanRate[a]['active'] = true;
            } else {
              kemudahanRate[a]['active'] = false;
            }
          }
          setState(() {});
        },
      );
    }

    _kecepatanStar(int i) {
      return IconButton(
        color: Colors.orange,
        icon: kecepatanRate[i - 1]['active'] == true
            ? Icon(Icons.star)
            : Icon(Icons.star_border),
        onPressed: () {
          for (var a = 0; a < kecepatanRate.length; a++) {
            if (a < i) {
              print(a);
              kecepatanRate[a]['active'] = true;
            } else {
              kecepatanRate[a]['active'] = false;
            }
          }
          setState(() {});
        },
      );
    }

    _kelengkapanStar(int i) {
      return IconButton(
        color: Colors.orange,
        icon: kelengkapanRate[i - 1]['active'] == true
            ? Icon(Icons.star)
            : Icon(Icons.star_border),
        onPressed: () {
          for (var a = 0; a < kelengkapanRate.length; a++) {
            if (a < i) {
              print(a);
              kelengkapanRate[a]['active'] = true;
            } else {
              kelengkapanRate[a]['active'] = false;
            }
          }
          setState(() {});
        },
      );
    }

    final tampilan = Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text('Bagaimana tampilan aplikasi?', textAlign: TextAlign.left),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  for (var i in tampilanRate) _tampilanStar(i['id']),
                ]),
          ],
        ));

    final kemudahan = Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text('Bagaimana kemudahan menggunakan aplikasi ?',
                textAlign: TextAlign.left),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  for (var i in kemudahanRate) _kemudahanStar(i['id']),
                ]),
          ],
        ));

    final kelengkapan = Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text('Bagaimana kelengkapan informasi aplikasi ?',
                textAlign: TextAlign.left),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  for (var i in tampilanRate) _kelengkapanStar(i['id']),
                ]),
          ],
        ));

    final kecepatan = Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text('Bagaimana kecepatan layanan menggunakan aplikasi ?',
                textAlign: TextAlign.left),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  for (var i in kecepatanRate) _kecepatanStar(i['id']),
                ]),
          ],
        ));

    final komentar = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 25.0),
          child: TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'Kritik Dan Saran', icon: Icon(Icons.add_comment)),
          ),
        ),
      ],
    );

    Future saveSurvey() async {}

    final saveButton = FunctionDart.saveButton(context, saveSurvey);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: FunctionDart.setAppBar("Survey Kepuasan"),
      body: Padding(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: ListView(
            children: <Widget>[
              tampilan,
              kemudahan,
              kelengkapan,
              kecepatan,
              komentar,
              saveButton,
            ],
          )),
    );
  }
}

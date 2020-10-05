import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:okkpd_mobile/model/komoditasModel.dart';

class ListKomoditas extends StatefulWidget {
  const ListKomoditas({Key key, this.komoditases}) : super(key: key);
  final List<KomoditasModel> komoditases;
  @override
  ListKomoditasState createState() => ListKomoditasState(komoditases);
}

class ListKomoditasState extends State<ListKomoditas> {
  final _normalFont = const TextStyle(fontSize: 14.0);
  final _smallFont = const TextStyle(fontSize: 12.0);
  ListKomoditasState(this.komoditases);
  final List<KomoditasModel> komoditases;

  _buildSuggestions() {
    return ListView.builder(
        itemCount: komoditases.length,
        itemBuilder: (context, i) {
          return _buildRow(komoditases[i]);
        });
  }

  _buildRow(KomoditasModel komoditas) {
    return ListTile(
        title: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                komoditas.namaJenisKomoditas,
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
            setState(() {
              komoditases.remove(komoditas);
            });
          },
          child: Icon(
            Icons.remove,
            color: Colors.white,
            size: 36,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildSuggestions(),
    );
  }
}

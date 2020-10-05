import 'package:flutter/material.dart';

class BasicTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Table Widget")),
      body: Table(
        defaultColumnWidth: FixedColumnWidth(150.0),
        border: TableBorder(
          horizontalInside: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid,
            width: 1.0,
          ),
          verticalInside: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid,
            width: 1.0,
          ),
        ),
        children: [
          _buildTableRow("Inducesmile.com, Google.com, Flutter.dev"),
          _buildTableRow("Inducesmile.com, Google.com, Flutter.dev"),
          _buildTableRow("Inducesmile.com, Google.com, Flutter.dev"),
          _buildTableRow("Inducesmile.com, Google.com, Flutter.dev"),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String listOfNames) {
    return TableRow(
      children: listOfNames.split(',').map((name) {
        return Container(
          alignment: Alignment.center,
          child: Text(name, style: TextStyle(fontSize: 20.0)),
          padding: EdgeInsets.all(8.0),
        );
      }).toList(),
    );
  }
}
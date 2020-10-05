import 'package:flutter/material.dart';
import 'package:okkpd_mobile/pages/media/mediaBodyWidget.dart';
import 'package:okkpd_mobile/tools/GlobalFunction.dart';

class MediaBody extends StatefulWidget {
  final String name;
  final String id;
  MediaBody(this.name, this.id);

  @override
  _MediaBody createState() => _MediaBody(name, id);
}

class _MediaBody extends State<MediaBody> {
  final String name;
  final String id;
  _MediaBody(this.name, this.id);

  int loop = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FunctionDart.setAppBar(this.name),
      // AppBar(
      //   title: Text(this.name, style: TextStyle(color: Colors.white)),
      // ),
      backgroundColor: Color.fromRGBO(239, 239, 239, 1),
      body: Center(child: MediaBodyWidget(this.id)),
    );
    // return Scaffold(
    //     appBar: AppBar(
    //       title: Text(this.name, style: TextStyle(color: Colors.white)),
    //     ),
    //     body: Container(
    //         child: Column(children: <Widget>[
    //       GridView.count(
    //         shrinkWrap: true,
    //         physics: new NeverScrollableScrollPhysics(),
    //         crossAxisSpacing: 4,
    //         mainAxisSpacing: 4,
    //         padding: EdgeInsets.only(left: 12, top: 16, right: 12, bottom: 12),
    //         crossAxisCount: 1,
    //         children: List.generate(1, (index) {
    //           return Center(
    //             child: MediaBodyWidget(index),
    //           );
    //         }),
    //       ),
    //       Container(
    //         padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: <Widget>[
    //             FlatButton(
    //               color: Colors.blue,
    //               textColor: Colors.white,
    //               disabledColor: Colors.grey,
    //               disabledTextColor: Colors.black,
    //               splashColor: Colors.blueAccent,
    //               onPressed: () {
    //                 _addCamera();
    //               },
    //               child: Text(
    //                 "Add",
    //                 style: TextStyle(fontSize: 16.0),
    //               ),
    //             ),
    //             FlatButton(
    //               color: Colors.red,
    //               textColor: Colors.white,
    //               disabledColor: Colors.grey,
    //               disabledTextColor: Colors.black,
    //               splashColor: Colors.redAccent,
    //               onPressed: () {
    //                 _removeCamera();
    //               },
    //               child: Text(
    //                 "Remove",
    //                 style: TextStyle(fontSize: 16.0),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ])));
  }
}

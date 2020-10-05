import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:okkpd_mobile/constants/key.dart';
import 'package:okkpd_mobile/pages/dashboard/notifikasiScreen.dart';

class CustomWidget{

  Widget loadingWidget(){
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Loading(color: Colors.blue, indicator: BallSpinFadeLoaderIndicator(), size: 40.0),
        SizedBox(height: 8,),
        Text("Loading", style: Keys().normalFontSize,)
      ],
    ),);
  }

  Widget imageError(){

    return Container(
      width: 56,
      child:
      Image.asset("assets/broken.png")
      ,
    );
  }

  Widget notifIcon(context,int totalNotif) {
    if (totalNotif > 0) {
      return new IconButton(
        icon: Image(height: 48, image: AssetImage('assets/notification_active.png')),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotifikasiScreen()),
          );
        },
      );
    } else {
      return new IconButton(
        icon: Image(height: 48, image: AssetImage('assets/notification.png')),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotifikasiScreen()),
          );
        },
      );
    }
  }
}
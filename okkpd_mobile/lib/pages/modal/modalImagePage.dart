import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ModalImagePage extends StatefulWidget {
  final String url;
  ModalImagePage(this.url);
  @override
  _ModalImagePage createState() => _ModalImagePage(this.url);
}

class _ModalImagePage extends State<ModalImagePage> {
  final String url;
  _ModalImagePage(this.url);

  @override
  void initState() {
    super.initState();
  }



  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: NetworkImage(
        this.url,
      ),
      // Contained = the smallest possible size to fit one dimension of the screen
      minScale: PhotoViewComputedScale.contained * 0.8,
      // Covered = the smallest possible size to fit the whole screen
      maxScale: PhotoViewComputedScale.covered * 2,
      enableRotation: true,
      // Set the background color to the "classic white"
      backgroundDecoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
      ),
      loadingChild: Center(
        child: CircularProgressIndicator(),
      ),
      // Image(
      //   image: NetworkImage(this.url),
      // ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share/share.dart';

import 'package:imorec/common/api/api_service.dart';
import 'package:imorec/util/toast.dart';

class MoviePhotoPreviewPage extends StatefulWidget {
  final List<ImageProvider> providers;
  final int index;
  final List<String> imageUrls;
  final PageController pageController;

  MoviePhotoPreviewPage(this.providers, this.index, this.imageUrls)
      : pageController = PageController(initialPage: index);
  
  @override
  _MoviePhotoPreviewPageState createState() => _MoviePhotoPreviewPageState();
}

class _MoviePhotoPreviewPageState extends State<MoviePhotoPreviewPage> {
  int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = this.widget.index;
  }

  void onBack() {
    Navigator.pop(context);
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void onLongPress(BuildContext context) {
    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            onPressed: () {
              Share.share(this.widget.imageUrls[currentIndex]);
            },
            child: Text('分享图片链接'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, '保存图片至相册');
              saveImageToAlbum(this.widget.imageUrls[currentIndex]);
            },
            child: Text('保存图片至相册'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, '取消');
          },
          child: Text('取消'),
          isDefaultAction: true,
        ),
      ),
    ).then((String value) {
      print(value);
    });
  }

  Future saveImageToAlbum(String imageUrl) async {
    Toast.showDarkGrey('正在保存...');

    ApiService apiService = ApiService();
    var response = await apiService.getImage(imageUrl);
    var filePath = await ImagePickerSaver.saveFile(
        fileData: response.bodyBytes);
    var savedFile = File.fromUri(Uri.file(filePath));
    Future<File>.sync(() => savedFile);
  
    Toast.showDarkGrey('保存成功');
  }

  @override
  Widget build(BuildContext context) {
    List<PhotoViewGalleryPageOptions> options = [];

    for (var i = 0; i < this.widget.providers.length; i++) {
      options.add(
        PhotoViewGalleryPageOptions(
          imageProvider: this.widget.providers[i],
          heroAttributes: PhotoViewHeroAttributes(tag: 'photo$i'),
        ),
      );
    }

    return Scaffold(
      body: GestureDetector(
        onLongPress: () {
          onLongPress(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              PhotoViewGallery(
                scrollPhysics: BouncingScrollPhysics(),
                pageOptions: options,
                pageController: this.widget.pageController,
                onPageChanged: onPageChanged,
                loadingBuilder: (context, progress) => CupertinoActivityIndicator(),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  '${currentIndex + 1} / ${this.widget.providers.length}',
                  style: TextStyle(color: Colors.white, fontSize: 16.0, decoration: null),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
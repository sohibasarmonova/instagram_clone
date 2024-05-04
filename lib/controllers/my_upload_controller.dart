import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/post_model.dart';
import '../services/db_service.dart';
import '../services/file_service.dart';

class MyUploadController extends GetxController{
  bool isLoading = false;
  var captionController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File? image;

  moveToFeed(PageController controller) {

      isLoading = false;
    update();
    captionController.text = "";
    image = null;
    controller.animateToPage(
        0, duration: const Duration(microseconds: 200), curve: Curves.easeIn);
  }

  imgFromGallery() async {
    XFile? img =
    await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);

      image = File(img!.path);
    update();
  }

  imgFromCamera() async {
    XFile? img =
    await _imagePicker.pickImage(source: ImageSource.camera, imageQuality: 50);

      image = File(img!.path );
    update();
  }

  void showPicker(BuildContext context,MyUploadController controller) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Pick Photo'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Take Photo'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }


  uploadNewPost(PageController pageController) {
    String caption = captionController.text.toString().trim();
    if (caption.isEmpty) return;
    if (image == null) return;
    apiPostImage(pageController);
  }
  void apiPostImage(PageController pageController){

      isLoading = true;
      update();
    FileService.uploadPostImage(image!).then((downloadUrl) => {
      resPostImage(downloadUrl,pageController),
    });
  }
  void resPostImage(String downloadUrl,PageController pageController){
    String caption = captionController.text.toString().trim();
    Post post = Post(caption, downloadUrl,);
    apiStorePost(post,pageController);
  }

  void apiStorePost(Post post, PageController pageController)async{
    // Post to posts
    Post posted = await DBService.storePost(post);
    // Post to feeds
    DBService.storeFeed(posted).then((value) => {
      moveToFeed(pageController),
    });
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/my_like_controller.dart';
import '../views/item_post.dart';

class MyLikesPage extends StatefulWidget {
  const MyLikesPage({super.key});

  @override
  State<MyLikesPage> createState() => _MyLikesPageState();
}

class _MyLikesPageState extends State<MyLikesPage> {
  final _controller = Get.find<MyLikeController>();


  @override
  void initState() {
    super.initState();
  _controller.apiLoadLikes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Likes",
          style: TextStyle(
              color: Colors.black, fontFamily: 'Billabong', fontSize: 30),
        ),
      ),
      body:GetBuilder<MyLikeController>(
        builder: (_){
          return  Stack(
            children: [
              ListView.builder(
                itemCount:_controller. items.length,
                itemBuilder: (ctx, index) {
                  return itemOfPost(_controller.items[index],context,_controller);
                },
              ),
              _controller. isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : const SizedBox.shrink(),
            ],
          );

        },
      )
    );
  }


}
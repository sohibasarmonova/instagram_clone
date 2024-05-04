import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ngdemo17/controllers/my_search_controller.dart';
import '../views/search_item.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({Key? key}) : super(key: key);

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  final _controller = Get.find<MySearchController>();

  @override
  void initState() {
    super.initState();
    _controller.apiSearchMembers("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Search",
            style: TextStyle(
                color: Colors.black, fontFamily: "Billabong", fontSize: 25),
          ),
        ),
        body: GetBuilder<MySearchController>(
          builder: (_) {
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      //#search member
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(7)),
                        child: TextField(
                          style: const TextStyle(color: Colors.black87),
                          controller: _controller.searchController,
                          decoration: const InputDecoration(
                              hintText: "Search",
                              border: InputBorder.none,
                              hintStyle:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                              icon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              )),
                        ),
                      ),

                      //#member list
                      Expanded(
                        child: ListView.builder(
                          itemCount: _controller.items.length,
                          itemBuilder: (ctx, index) {
                            return itemOfMember(_controller.items[index],_controller);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}

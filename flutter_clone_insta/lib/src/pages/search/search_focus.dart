import 'package:flutter/material.dart';
import 'package:flutter_clone_insta/src/components/image_data.dart';
import 'package:get/get.dart';

import '../../controller/bottom_nav_controller.dart';

class SearchFocus extends StatefulWidget {
  const SearchFocus({Key? key}) : super(key: key);

  @override
  _SearchFocusState createState() => _SearchFocusState();
}

class _SearchFocusState extends State<SearchFocus>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
            // onTap: Get.back,
          onTap:BottomNavController.to.willPopAction,
          //() {
          //   BottomNavController.to.willPopAction();
          //   // Get.find<BottomNavController>().willPopAction();
          // },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(IconsPath.backBtnIcon),
            )),
        titleSpacing: 0,
        title: Container(
          margin: EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xffefefef)),
          child: const TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '검색',
                contentPadding: EdgeInsets.only(left: 15, top: 7, bottom: 7),
                isDense: true),
          ),
        ),
        bottom: _tabMenu(),
      ),
      body: _body(),
    );
  }

  Widget tabMenuOne(String menu) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Text(
        menu,
        style: TextStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }

  PreferredSizeWidget _tabMenu() {
    return PreferredSize(
      child: Container(
        height: 50,
        width: Size.infinite.width,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xffe4e4e4)))),
        child: TabBar(
            controller: tabController,
            indicatorColor: Colors.black,
            tabs: [
              tabMenuOne('인기'),
              tabMenuOne('계정'),
              tabMenuOne('오디오'),
              tabMenuOne('태그'),
              tabMenuOne('장소'),
            ]),
      ),
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
    );
  }

  Widget _body() {
    return Container(
      child: TabBarView(
        controller: tabController,
        children: const [
          Center(child: Text('인기페이지')),
          Center(child: Text('계정페이지')),
          Center(child: Text('오디오페이지')),
          Center(child: Text('태그페이지')),
          Center(child: Text('장소페이지')),
        ],
      ),
    );
  }
}

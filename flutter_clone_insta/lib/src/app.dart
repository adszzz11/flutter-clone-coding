import 'package:flutter/material.dart';
import 'package:flutter_clone_insta/src/components/image_data.dart';
import 'package:flutter_clone_insta/src/controller/bottom_nav_controller.dart';
import 'package:flutter_clone_insta/src/pages/home.dart';
import 'package:flutter_clone_insta/src/pages/search.dart';
import 'package:get/get.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Obx(
            () =>
            Scaffold(
              body: IndexedStack(
                index: controller.pageIndex.value,
                children: [
                  const Home(),
                  Navigator(key: controller.searchPageNavigationKey,
                    onGenerateRoute: (routeSetting) {
                      return MaterialPageRoute(builder: (context) => Search());
                    },),
                  // const Search(),
                  Container(child: Center(child: Text('upload')),),
                  Container(child: Center(child: Text('activity')),),
                  Container(child: Center(child: Text('mypage')),),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: controller.pageIndex.value,
                elevation: 0,
                onTap: controller.changeBottomNav,
                items: [
                  BottomNavigationBarItem(
                      icon: ImageData(IconsPath.homeOff),
                      activeIcon: ImageData(IconsPath.homeOn),
                      label: 'home'),
                  BottomNavigationBarItem(
                      icon: ImageData(IconsPath.searchOff),
                      activeIcon: ImageData(IconsPath.searchOn),
                      label: 'search'),
                  BottomNavigationBarItem(
                      icon: ImageData(IconsPath.uploadIcon),
                      // activeIcon: ImageData(IconsPath.homeOn),
                      label: 'upload'),
                  BottomNavigationBarItem(
                      icon: ImageData(IconsPath.activeOff),
                      activeIcon: ImageData(IconsPath.activeOn),
                      label: 'active'),
                  BottomNavigationBarItem(
                      icon: Container(
                        width: 30,
                        height: 30,
                        decoration:
                        BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                      ),
                      activeIcon: ImageData(IconsPath.homeOn),
                      label: 'home'),
                ],
              ),
            ),
      ),
      onWillPop: controller.willPopAction,
    );
  }
}

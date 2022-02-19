import 'package:get/get.dart';

enum PageName { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE }

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;

  void changeBottomNav(int value) {
    var page = PageName.values[value];

    switch (page) {
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
      case PageName.HOME:
      case PageName.SEARCH:
        _changePage(value);
        break;
      case PageName.UPLOAD:
        Get.to(() {

        });
        break;
    }
  }

  void _changePage(int value) {
    pageIndex(value);
  }
}

import 'package:get/get.dart';

import '../../pages/upload.dart';

enum PageName { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE }

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];

  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];

    switch (page) {
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
      case PageName.HOME:
      case PageName.SEARCH:
        _changePage(value, hasGesture: hasGesture);
        break;
      case PageName.UPLOAD:
        Get.to(() => const Upload());
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
    if (bottomHistory.contains(value)) {
      bottomHistory.remove(value);
    }
    bottomHistory.add(value);
    print(bottomHistory);

  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1) {
      print('exit');
      return true;
    } else {
      bottomHistory.removeLast();
      print(bottomHistory);
      changeBottomNav(bottomHistory.last, hasGesture: false);
      return false;
    }
  }
}

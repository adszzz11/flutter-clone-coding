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

  DateTime? previousTime = null;
  int popCounter = 0;

  Future<bool> willPopAction() async {

    // 배경 시간
    DateTime currentTime = DateTime.now();

    // 최초 뒤로가기 버튼을 눌렀을 경우
    previousTime == null ? previousTime = currentTime : null;

    if (currentTime.difference(previousTime!).inSeconds.toInt() < 5) {

      // 5초 전 뒤로가기 버튼을 눌렀을 경우
      print('5초 전 뒤로가기 버튼 누름.');
      popCounter++;
      print(popCounter);
      if(popCounter==2) {
        print('두 번 연속 뒤로가기 누름');
        //뒤로가기 버튼을 두 번 눌렀을 경우
        bottomHistory.clear();
        popCounter=0;
        print(popCounter);
        changeBottomNav(0);
        return false;
      }
    } else {
      print('5초 뒤 뒤로가기 버튼 누름. 초기화');
      // 5초 뒤 뒤로가기 버튼을 눌렀을 경우
      previousTime = currentTime;
      popCounter = 1;
    }

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

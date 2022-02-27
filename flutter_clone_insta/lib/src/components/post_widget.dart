import 'package:flutter/material.dart';
import 'package:flutter_clone_insta/src/components/avater_widget.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(top: 20),
      color: Colors.red,
      child: Column(children: [
        _header(),
        // _image(),
        // _infoCount(),
        // _infoDescription(),
        // _replyTextBtn(),
        // _dateAgo(),
      ],),
    );
  }

  Widget _header() {
    return Row(
      children: [
        AvatarWidget(thumbPath: '', type: AvatarType.TYPE3),
      ],
    );
  }
}

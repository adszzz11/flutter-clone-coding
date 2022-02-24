import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum AvatarType { TYPE1, TYPE2, TYPE3, TYPE4 }

class AvatarWidget extends StatelessWidget {
  bool? hasStory;
  String thumbPath;
  String? nickname;
  AvatarType type;
  double? size;

  AvatarWidget(
      {required this.thumbPath,
      required this.type,
      this.hasStory,
      this.nickname,
      this.size,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AvatarType.TYPE1:
        return type1Widget();
        break;
      case AvatarType.TYPE2:
        // return type2Widget();
        break;
      case AvatarType.TYPE3:
        // return type3Widget();
        break;
      case AvatarType.TYPE4:
        // TODO: Handle this case.
        break;
    }
    return Container();
  }

  Widget type1Widget() {
    return Container(
      width: 65,
      height: 65,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.purple, Colors.orange]),
          shape: BoxShape.circle,
          color: Colors.grey),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(65),
        child: Container(
          width: 65,
          height: 65,
          child: CachedNetworkImage(
            imageUrl: thumbPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

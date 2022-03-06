import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_clone_insta/src/components/image_data.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  var albums = <AssetPathEntity>[];
  var headerTitle = '';
  var imageList = <AssetEntity>[];
  AssetEntity? selectImage;

  @override
  void initState() {
    super.initState();
    _loadPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(IconsPath.closeImage),
          ),
        ),
        title: const Text(
          'New Post',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.nextImage,
                width: 50,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imagePreview(),
            _header(),
            _imageSelectList(),
          ],
        ),
      ),
    );
  }

  Widget _imagePreview() {
    var width = MediaQuery.of(context).size.width;
    return Container(
        width: width,
        height: width,
        color: Colors.grey,
        child: selectImage == null
            ? Container()
            : _photoWidget(selectImage!, width.toInt(), builder: (data) {
                return Image.memory(
                  data,
                  fit: BoxFit.cover,
                );
              }));
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  headerTitle,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: const Color(0xff808080),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    ImageData(IconsPath.imageSelectIcon),
                    Text(
                      '여러 항목 선택',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xff808080)),
                child: ImageData(IconsPath.cameraIcon),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _imageSelectList() {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1),
        itemCount: imageList.length,
        itemBuilder: (BuildContext context, int index) {
          return _photoWidget(imageList[index], 200, builder: (data) {
            return Opacity(
              opacity: imageList[index] == selectImage ? 0.3 : 1,
              child: Image.memory(
                data,
                fit: BoxFit.cover,
              ),
            );
          });
        });
  }

  void _loadPhotos() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          imageOption: const FilterOption(
            sizeConstraint: SizeConstraint(minHeight: 100, minWidth: 100),
          ),
          orders: [
            const OrderOption(type: OrderOptionType.createDate, asc: false),
          ],
        ),
      );
      _loadData();
    } else {
      //msg require permission
    }
  }

  void _loadData() async {
    headerTitle = albums.first.name;
    await _pagingPhotos();
    update();
  }

  void update() => setState(() {});

  Future<void> _pagingPhotos() async {
    var photos = await albums.first.getAssetListPaged(0, 30);
    imageList.addAll(photos);
    selectImage = imageList.first;
  }

  Widget _photoWidget(AssetEntity asset, int size,
      {required Widget Function(Uint8List) builder}) {
    return FutureBuilder(
        future: asset.thumbDataWithSize(size, size),
        builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
          if (snapshot.hasData) {
            return builder(snapshot.data!);
          } else {
            return Container();
          }
        });
  }
}

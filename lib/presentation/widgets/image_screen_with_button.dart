import 'package:flutter/material.dart';

import '../../core/extensions/widget_scale.dart';

class ImageScreenWithButton extends StatelessWidget {
  final String image;
  final Widget button;

  const ImageScreenWithButton({
    super.key,
    required this.image,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('개발중'), behavior: SnackBarBehavior.floating),
        );
      },
      // TODO: 프로필 이미지 확대 기능 (파이어베이스 요금제 업그레이드 필요)
      // onTap: () => Navigator.of(context).push(
      //   MaterialPageRoute(
      //     barrierDismissible: true,
      //     builder: (context) => Scaffold(
      //       extendBody: true,
      //       extendBodyBehindAppBar: true,
      //       backgroundColor: Colors.black,
      //       appBar: AppBar(
      //         iconTheme: IconThemeData(color: Colors.white),
      //         leading: PopButton(),
      //         backgroundColor: Colors.transparent,
      //       ),
      //       body: InteractiveViewer(
      //         child: Center(
      //           child: image.isNetworkImage()
      //               ? Image.network(image)
      //               : Image.file(File(image)),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      child: button,
    ).scale();
  }
}

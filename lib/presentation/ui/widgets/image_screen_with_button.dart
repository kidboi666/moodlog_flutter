import 'package:flutter/material.dart';

import '../../../core/extensions/snack_bar.dart';
import '../../../core/extensions/widget_scale.dart';
import '../../../core/l10n/app_localizations.dart';

class ImageScreenWithButton extends StatelessWidget {
  final String? image;
  final Widget button;

  const ImageScreenWithButton({super.key, this.image, required this.button});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () {
        context.showSnackBar(
          SnackBar(
            content: Text(t.common_developing),
            behavior: SnackBarBehavior.floating,
          ),
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/color.dart';
import '../widget/gradient_button.dart';

class MsgBottomSheet extends StatelessWidget {
  final String msg;
  final String title;
  final String imagePath;
  final Color? color;

  const MsgBottomSheet({
    super.key,
    required this.msg,
    required this.title,
    required this.imagePath,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        size.width * 0.05581395348,
        size.height * 0.05206073752,
        size.width * 0.05581395348,
        size.height * 0.05206073752,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(imagePath),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            msg,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03326403326),
          IntrinsicHeight(
            child: GradientButton(
              text: "Ok",
              //AppLocalizations.of(context)!.ok,
              onTap: () => Navigator.pop(context),
              height: size.height * 0.06237006237,
              width: size.width,
              color: COLORs.blue1
            ),
          ),
        ],
      ),
    );
  }
}
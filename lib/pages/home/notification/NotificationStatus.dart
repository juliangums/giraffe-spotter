import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/widgets/ArrowBackButton.dart';
import 'package:giraffe_spotter/widgets/LargeButton.dart';
import 'package:giraffe_spotter/widgets/PageWrapper.dart';

class NotificationStatus extends StatelessWidget {
  final String image, description, feedback;
  final bool status;
  NotificationStatus({required this.description, required this.image, required this.status, required this.feedback, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: "",
      leading: ArrowBackButton(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 29),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          Container(
            margin: EdgeInsets.only(top: 80),
            padding: EdgeInsets.only(bottom: status ? 80 : 0),
            height: 260,
            width: 260,
            child: Center(child: status ?  SvgPicture.asset(Assets.successIcon): SvgPicture.asset(Assets.rejectedIcon)),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(image), fit: BoxFit.fill, colorFilter: ColorFilter.mode(Palette.imageFilterColor, BlendMode.lighten)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  status ? Text(
                      feedback,
                      style: Styles.successTextColor,
                      textAlign: TextAlign.center):
                  Text(
                    feedback,
                    style: Styles.warningTextColor,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    description,
                    style: Styles.messageTextColor,
                    textAlign: TextAlign.center,
                  ),
                ],
              )
          ),
          status ? LargeButtonReplacement(
                  title: "Review Best Practice",
                  onTap: () {},
                ): LargeButtonReplacement(
            title: "View Giraffe",
            onTap: () {},
          )
        ],
      )),
    );
  }
}

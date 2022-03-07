import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Constants.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/pages/edit_profile/ProfileEdit.dart';
import 'package:giraffe_spotter/utils/SharedObjects.dart';
import 'package:giraffe_spotter/widgets/DisplayPhoto.dart';

class ProfileDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 21, top: 26),
      child: Row(
        children: [
          DisplayPhoto(drawerClose: true),
          SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width/2.4,
                child: Text(
                  SharedObjects.prefs!.getString(Constants.name).toString().isNotEmpty?
                  SharedObjects.prefs!.getString(Constants.name).toString(): '',
                  style: Styles.profileName,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 9),
              SizedBox(
                width: MediaQuery.of(context).size.width/2.4,
                child: Text(
                    SharedObjects.prefs!.getString(Constants.userEmail).toString().isNotEmpty?
                    SharedObjects.prefs!.getString(Constants.userEmail).toString(): '',
                    style: Styles.profileEmail,
                    overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            key: Key('editProfile'),
            onTap: () async{
              locator!<AppRoute>().back();
               locator!<AppRoute>().navigateTo(ProfileEdit());
            },
            child: SvgPicture.asset(Assets.edit),
          ),
        ],
      ),
    );
  }
}

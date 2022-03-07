import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/blocs/authentication/logout/LogoutCubit.dart';
import 'package:giraffe_spotter/blocs/home/BottomBarCubit.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/pages/authentication/Login.dart';
import 'package:giraffe_spotter/pages/delete_account/DeletePage.dart';
import 'package:giraffe_spotter/pages/delete_account/widgets/ContainModalBottom.dart';
import 'package:giraffe_spotter/pages/invite_friends/InvitePage.dart';
import 'package:giraffe_spotter/widgets/GradientSnackBar.dart';
import 'package:giraffe_spotter/widgets/LoadingWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuItems extends StatelessWidget {
  final String icon;
  final String title;
  final int index;

  const MenuItems({Key? key, required this.icon, this.index = 2, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return title == 'Log Out'
        ? BlocListener<LogoutCubit, LogoutState>(
            listener: listenerLogout,
            listenWhen: (prev, current) => prev != current,
            child: ListTile(
              //future create a method to nav to diff. pages once all are done...
              onTap: () {
                pageChecker(title, context);
              },
              key: Key('menuItem${index.toString()}'),
              leading: Container(width: 30, child: SvgPicture.asset(icon)),
              contentPadding: EdgeInsets.only(left: 20),
              minLeadingWidth: title == 'Log Out' ? 35.5 : 38,
              title: Text(title, style: Styles.menuItems),
            ),
          )
        : ListTile(
            //future create a method to nav to diff. pages once all are done...
            onTap: () {
              locator!<AppRoute>().back();
              pageChecker(title, context);
            },
            key: Key('menuItem${index.toString()}'),
            leading: Container(width: 30, child: SvgPicture.asset(icon)),
            contentPadding: EdgeInsets.only(left: 20),
            minLeadingWidth: title == 'Log Out' ? 35.5 : 38,
            title: Text(title, style: Styles.menuItems),
          );
  }

  //builds the Bottom dialog
  void logoutModalConfirm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        ),
        builder: (context) => GestureDetector(onTap:()=>Navigator.pop(context),child: ContainModalBottom(contextS: context, select: false))
    );
  }

  _launchURL(String _url) async => await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

  void pageChecker(title, BuildContext context) {
    if (title == 'Delete Account') {
      locator!<AppRoute>().navigateTo(DeletePage());
    } else if (title == 'Invite friends') {
      locator!<AppRoute>().navigateTo(InvitePage());
    } else if (title == 'About Us') {
      _launchURL('https://giraffeconservation.org/who-is-gcf/');
    } else if (title == 'Adoption') {
      _launchURL('https://adopt.giraffeconservation.org/');
    } else if (title == 'Donation') {
      _launchURL('https://giraffeconservation.org/donate/');
    } else if (title == 'Log Out') {
      logoutModalConfirm(context);
    }
  }

  void listenerLogout(BuildContext context, LogoutState state) {
    if (state.formzStatus == FormzStatus.submissionSuccess) {
      LoadingIndicatorWidget2.hide();
      locator!<AppRoute>().navigateAndRemoveUntil(Login());
    }

    if (state.formzStatus == FormzStatus.submissionInProgress) {
      LoadingIndicatorWidget2.show(context);
    }

    if (state.formzStatus == FormzStatus.submissionFailure) {
      LoadingIndicatorWidget2.hide();
      GradientSnackBar.showPrimaryMessage(context, 'Logout Failed');
    }
  }
}

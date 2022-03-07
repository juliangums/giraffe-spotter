import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/widgets/CustomContainer.dart';
import 'package:giraffe_spotter/widgets/LargeButton.dart';
import 'package:giraffe_spotter/widgets/PageWrapper.dart';

class NoNetworkPage extends StatelessWidget {
  // bool initstate = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPopScope,
      child: Scaffold(
        body: PageWrapper(
          leading: Container(),
          title: '',
          actions: [SizedBox()],
          child: CustomContainer(
            child: Column(
              children: [
                SvgPicture.asset(Assets.noNetwork),
                SizedBox(height: 46),
                Text('No Internet', style: Styles.appBarTitle),
                SizedBox(height: 21),
                DelayedDisplay(
                  delay: Duration(milliseconds: (5)),
                  child: Text(
                    'Looks like something went wrong! \nMake sure you’re connected to the internet and \ntry again.',
                    textAlign: TextAlign.center,
                    style: Styles.deleteAccountDetails,
                  ),
                  slidingBeginOffset: Offset(0.0, 0),
                ),
                SizedBox(height: 50),
                Flexible(
                  child: LargeButton(
                    title: 'Retry',
                    // onTap: () async {
                    //   DataConnectionStatus result = await DataConnectionChecker().connectionStatus;
                    //   if (result != DataConnectionStatus.disconnected) {
                    //     if (initstate == false) locator!<AppRoute>().back(params: true);
                    //     setState(() {
                    //       initstate = true;
                    //     });
                    //   } else {
                    //     final snackBar = SnackBar(
                    //       content: Text('Make sure you’re connected to the internet'),
                    //     );
                    //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    //   }
                    // },
                    onTap: () async {
                      DataConnectionStatus result = await DataConnectionChecker().connectionStatus;
                      if (result != DataConnectionStatus.disconnected) {
                        locator!<AppRoute>().back(params: true);
                      } else {
                        final snackBar = SnackBar(
                          content: Text('Make sure you’re connected to the internet'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    widthSize: 25.0,
                    heightSize: 54,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // void initState() {
  //   initstate = false;
  // }

  Future<bool> onWillPopScope() async {
    DataConnectionStatus result = await DataConnectionChecker().connectionStatus;
    if (result != DataConnectionStatus.disconnected) {
      return true;
    }

    return false;
  }
}

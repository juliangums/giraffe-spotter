import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giraffe_spotter/blocs/home/BottomBarCubit.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/pages/home/pages/Home.dart';
import 'package:giraffe_spotter/pages/home/pages/HomePage.dart';
import 'package:giraffe_spotter/widgets/CustomContainer.dart';
import 'package:giraffe_spotter/widgets/LargeButton.dart';
import 'package:giraffe_spotter/widgets/PageWrapper.dart';

class UploadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: WillPopScope(
           onWillPop: () => backHome(),
           child: PageWrapper(
                  leading: Container(),
                  title: '',
                  actions: [SizedBox()],
                  child: CustomContainer(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 100),
                              SvgPicture.asset(Assets.uploadPic),
                              SizedBox(height: 50),
                              Text('Upload Successful', style: Styles.uploadSuccessful),
                              SizedBox(height: 21),
                              DelayedDisplay (
                                delay: Duration(milliseconds: (5)),
                                child: Text (
                                  'You will receive a notification \nonce we finish reviewing your \nsubmission.',
                                  textAlign: TextAlign.center,
                                  style: Styles.uploadSuccessfulDetails,
                                ),
                                slidingBeginOffset: Offset(0.0, 0),
                              ),
                              SizedBox(height: 50),
                              LargeButton(
                                title: 'Take me Home',
                                onTap: () {
                                  BlocProvider.of<BottomBarCubit>(context).updateIndex(0);
                                  locator!<AppRoute>().navigateAndRemoveUntil(HomePage());
                                } ,
                                widthSize: 27.0,
                                heightSize: 52,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ),
              ),
         )
    );
  }
  backHome(){
    locator!<AppRoute>().navigateAndReplace(Home());
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Decorations.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/pages/home/widgets/Search.dart';
import 'package:giraffe_spotter/widgets/ShimmerWidget.dart';

import 'SpinKitFadingCircle.dart';

class LoadingSearchBar extends StatelessWidget {
  final double bottom;
  final double horizontal;

  const LoadingSearchBar({Key? key, this.bottom = 24, this.horizontal = 29})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ShimmerWidget.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          margin: EdgeInsets.only(bottom: bottom),
          padding: EdgeInsets.symmetric(horizontal: horizontal),
          child: SearchField(diffSearch: ''),
        ),
      ),
    );
  }
}

class GridViewLoadingWidget extends StatelessWidget {
  final double horizontal;
  final double top;
  final double left;
  final double right;
  final double bottom;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double childAspectRatio;
  final bool video;

  const GridViewLoadingWidget(
      {Key? key,
      this.horizontal = 19,
      this.top = 14,
      this.left = 10,
      this.right = 10,
      this.bottom = 40,
      this.crossAxisCount = 2,
      this.crossAxisSpacing = 20,
      this.mainAxisSpacing = 18,
      this.childAspectRatio = 0.81,
      this.video = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      width: width,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding:
            EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (context, index) {
          return LoadingArticleCardWidget(video: video);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            childAspectRatio: childAspectRatio),
      ),
    );
  }
}

class LoadingArticleCardWidget extends StatelessWidget {
  final bool video;

  LoadingArticleCardWidget({this.video = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Decorations.cardSliderDecoration(),
      child: ShimmerWidget.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Container(
                color: Colors.grey[300],
                width: video ? 148 : double.infinity,
                height: video ? 128 : MediaQuery.of(context).size.height * 0.16,
              ),
            ),
            Expanded(
                child: Container(
                  width: video ? 148 : double.infinity,
                  padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 15,
                        color: Colors.red,
                        constraints: BoxConstraints(maxWidth: 63),
                        margin: EdgeInsets.only(bottom: 5),
                      ),
                      Container(
                        height: 15,
                        color: Colors.red,
                        constraints: BoxConstraints(maxWidth: 123),
                        margin: EdgeInsets.only(bottom: 5),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class LoadingPlaceHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShimmerWidget.fromColors(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        child: Container(
          color: Colors.red,
          height: 140,
        ),
      ),
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
    );
  }
}

class LoadingListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      padding: EdgeInsets.only(left: 20),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(left: 4, right: 18, bottom: 4),
          child: LoadingArticleCardWidget(video: true),
        );
      },
    );
  }
}

class LoadingIndicatorWidget2 extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog(
          context: context,
          useRootNavigator: false,
          barrierDismissible: false,
          barrierColor: Palette.primaryColor,
          builder: (_) => LoadingIndicatorWidget2(key: key))
      .then((value) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide() => locator!<AppRoute>().back();

  LoadingIndicatorWidget2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: SpinKitFadingCircle(color: Palette.accentColor, size: 54),
        ),
      ),
    ); // WillPopScope
  }
}

import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/giraffe_fav/FavouriteState.dart';
import 'package:giraffe_spotter/blocs/home/profile/GiraffeFavCubit.dart';
import 'package:giraffe_spotter/blocs/home/profile/GiraffeFavState.dart';
import 'package:giraffe_spotter/blocs/home/profile/GiraffeProfileStringCubit.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/models/DropDownData.dart';
import 'package:giraffe_spotter/models/GiraffeData.dart';
import 'package:giraffe_spotter/pages/home/pages/HomePage.dart';
import 'package:giraffe_spotter/pages/home/pages/WebView.dart';
import 'package:giraffe_spotter/pages/home/widgets/DonateButton.dart';
import 'package:giraffe_spotter/providers/FavouriteProvider.dart';
import 'package:giraffe_spotter/utils/Extensions.dart';
import 'package:giraffe_spotter/widgets/ImageWidget.dart';
import 'package:giraffe_spotter/widgets/PageWrapper.dart';
import 'package:giraffe_spotter/widgets/ShareButton.dart';
import 'package:giraffe_spotter/widgets/ZoomImage.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

//open builder ...

class GiraffeProfilePage extends StatelessWidget {
  GiraffeProfilePage({required this.giraffeData, this.favState, this.indexes, this.fav = false, this.home = true});

  final GiraffeData? giraffeData;
  final bool fav;
  final int? indexes;
  final bool? home;
  final FavouriteState? favState;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GiraffeFavCubit(initialValue: fav == true ? 1 : 0, favouriteProvider: new FavouriteProvider()),
      child: BlocProvider<GiraffeProfileStringCubit>(
        create: (_) => GiraffeProfileStringCubit()..captureDataItems(giraffeData!),
        child: BlocBuilder<GiraffeFavCubit, GiraffeFavState>(
          builder: (context, status) {
            return BlocBuilder<GiraffeProfileStringCubit, String?>(
              builder: (context, state) {
                return WillPopScope(
                  onWillPop: () => home == true
                      ? indexes != null
                          ? locator!<AppRoute>().back(params: status.initialValue == 0 ? true : false)
                          : locator!<AppRoute>().back(params: context.read<GiraffeFavCubit>().backRefresh)
                      : locator!<AppRoute>().navigateAndRemoveUntil(HomePage()),
                  child: PageWrapper(
                    title: "Giraffe Profile",
                    leading: GestureDetector(
                      onTap: () => home == true
                          ? indexes != null
                              ? locator!<AppRoute>().back(params: status.initialValue == 0 ? true : false)
                              : locator!<AppRoute>().back(params: context.read<GiraffeFavCubit>().backRefresh)
                          : locator!<AppRoute>().navigateAndRemoveUntil(HomePage()),
                      child: Padding(
                        padding: EdgeInsets.only(left: 24, right: 10),
                        child: Icon(Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios, color: Palette.dividerColor),
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 29),
                        child: ShareButton(shareLink: 'giraffe', id: giraffeData!.id, shareit: true),
                      )
                    ],
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 29),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => locator!<AppRoute>().navigateTo(ZoomImage(image: state)),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.24,
                                  margin: EdgeInsets.only(top: 16, bottom: 18),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      child: OpenContainer<bool>(
                                        transitionType: ContainerTransitionType.fadeThrough,
                                        openBuilder: (BuildContext _, VoidCallback openContainer) {
                                          return ZoomImage(image: state);
                                        },
                                        tappable: true,
                                        closedShape: const RoundedRectangleBorder(),
                                        closedElevation: 0.0,
                                        closedBuilder: (BuildContext _, VoidCallback openContainer) {
                                          return ImageWidget(image: state, page: false);
                                        },
                                      )),
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.11,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: context.read<GiraffeProfileStringCubit>().images.length,
                                  padding: EdgeInsets.only(right: 29),
                                  itemBuilder: (context, _index) {
                                    final media = context.read<GiraffeProfileStringCubit>().images[_index];
                                    return InkWell(
                                      onTap: () => context.read<GiraffeProfileStringCubit>().setImage(media),
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                                        width: MediaQuery.of(context).size.width / 4,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            child: ImageWidget(image: media, page: false)),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [Text(giraffeData!.nickname.isEmpty ? '' : giraffeData!.nickname, style: Styles.cardSlideTitle)],
                              ),
                              SizedBox(height: 7),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_outlined, color: Palette.accentColor, size: 15),
                                          SizedBox(width: 5),
                                          Text(
                                            giraffeData!.encounters[0].locality == null
                                                ? 'Unknown location'
                                                : giraffeData!.encounters[0].locality,
                                            style: Styles.locationTitle,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      giraffeData!.sex == 'male' || giraffeData!.sex == 'M' || giraffeData!.sex == 'Male'
                                          ? SvgPicture.asset(Assets.maleIcon)
                                          : giraffeData!.sex == 'female' || giraffeData!.sex == 'F' || giraffeData!.sex == 'female'
                                              ? SvgPicture.asset(Assets.donation)
                                              : Container(),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 18),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 13, right: 13, top: 5, bottom: 5),
                                    height: 46,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Palette.borderColor),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          giraffeData!.encounters[0].age.toString() == 'null' ||
                                                  giraffeData!.encounters[0].age.toString().isEmpty
                                              ? 'Unknown'
                                              : giraffeData!.encounters[0].age.toString() + ' months',
                                          style: Styles.dataText,
                                        ),
                                        Text("Age", style: Styles.dataSubtitleText),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 13, right: 13, top: 5, bottom: 5),
                                    height: 46,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Palette.borderColor),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 120,
                                          child: Text(
                                            giraffeData!.encounters.length == 0
                                                ? 'Unknown'
                                                : giraffeData!.encounters[0].species.isEmpty
                                                    ? 'Unknown'
                                                    : DropDownData()
                                                                .listSpecies
                                                                .firstWhere(
                                                                    (element) => element.value == giraffeData!.encounters[0].species,
                                                                    orElse: () => DropDownData().listSpecies[0])
                                                                .name !=
                                                            'Select All'
                                                        ? DropDownData()
                                                            .listSpecies
                                                            .firstWhere((element) => element.value == giraffeData!.encounters[0].species)
                                                            .name
                                                        : 'Unknown',
                                            overflow: TextOverflow.ellipsis,
                                            textAlign:
                                                // giraffeData!.genus.isEmpty ?
                                                TextAlign.center,
                                            // : TextAlign.start,
                                            maxLines: 1,
                                            style: Styles.dataText,
                                          ),
                                        ),
                                        Text("Species", style: Styles.dataSubtitleText),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: 25,
                                      child: GestureDetector(
                                        onTap: () {
                                          context.read<GiraffeFavCubit>().state.initialValue == 0
                                              ? context.read<GiraffeFavCubit>().addFavourite(giraffeData!.id)
                                              : context.read<GiraffeFavCubit>().unFavourite(giraffeData!.id);
                                          context.read<GiraffeFavCubit>().backRefresh = true;
                                        },
                                        child: status.initialValue == 0
                                            ? SvgPicture.asset(Assets.heart, height: 23, width: 23)
                                            : SvgPicture.asset(Assets.ActiveHeart, height: 25, width: 25),
                                      ))
                                ],
                              ),
                              SizedBox(height: 18),
                              Info(
                                  numberOfEncounter: giraffeData!.number_of_encounters.toString().isEmpty
                                      ? 'Unknown'
                                      : giraffeData!.number_of_encounters.toString(),
                                  lastSeenAt: giraffeData!.last_seen_at == null ? 'Unknown' : giraffeData!.last_seen_at,
                                  sex: giraffeData!.sex == null || giraffeData!.sex.isEmpty ? 'Unknown' : giraffeData!.sex,
                                  comments: giraffeData!.comments == 'None'
                                      ? ''
                                      : Bidi.stripHtmlIfNeeded(giraffeData!.comments).replaceAll('UTC', '')),
                              SizedBox(height: 18),
                              Container(padding: EdgeInsets.only(left: 64, right: 23), child: BottomButtons()),
                              SizedBox(height: 36),
                            ],
                          ),
                        ),
                        Container(height: MediaQuery.of(context).size.height * 0.6, child: WebViewExample(id: giraffeData!.id))
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class Info extends StatelessWidget {
  Info({this.numberOfEncounter, this.sex, this.lastSeenAt, this.comments});

  final String? numberOfEncounter, sex, lastSeenAt, comments;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Number of encounters: ', style: Styles.dataText),
            Text('$numberOfEncounter', style: Styles.articleBodyText.copyWith(fontSize: 12))
          ],
        ),
        Row(
          children: [
            Text('Last seen: ', style: Styles.dataText),
            Text(lastSeenAt == 'Unknown' ? lastSeenAt! : DateTime.parse(lastSeenAt.toString()).timeago(),
                style: Styles.articleBodyText.copyWith(fontSize: 12))
          ],
        ),
      ],
    );
  }
}

class BottomButtons extends StatelessWidget {
  _launchURL(String _url) async => await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: TextButton(
              onPressed: () => _launchURL('https://adopt.giraffeconservation.org/'),
              child: Text("Adopt", style: Styles.adoptText),
            ),
          ),
          SizedBox(width: 50),
          Flexible(child: DonateButton(label: "Donate", action: () => _launchURL('https://giraffeconservation.org/donate/')))
        ],
      ),
    );
  }
}

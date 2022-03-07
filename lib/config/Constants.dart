import 'package:giraffe_spotter/pages/home/widgets/CardSlide.dart';
import 'package:giraffe_spotter/pages/home/widgets/Notification.dart';
import 'package:giraffe_spotter/pages/learn/widgets/Park.dart';

import 'Assets.dart';

class Constants {
  static const String gender = 'gender';
  static const String location = 'location';
  static const String species = 'species';
  static const String ageStart = 'ageStart';
  static const String ageEnd = 'ageEnd';
  static const String accessToken = 'accessToken';
  static const String logged = 'logged';
  static const String name = 'name';
  static const String firstRun = "firstRun";
  static const String userEmail = 'email';
  static const String userImage = 'image';
  static const String userid = 'uuid';
  static const String apiKey = 'API_KEY';
  static const String reset = 'resetToken';
  static const String SmartLookKey = '10e5233a7cecc2774bd9ec487c0408042b247cdc';
  static const String mapBoxToken = 'pk.eyJ1Ijoic3ludGF4bHRkIiwiYSI6ImNqeWgxanp6dzAwcmozbXBlejA0anBhOXoifQ.44mOLJDLY-oL45oicaZtuw';
  static const String learnAbout =
      'is a photo-identification\ndatabase of giraffe encounters and\nindividually catalogued giraffe. The database\nis maintained and used by giraffe\nconservationists, biologists and managers to\ncollect and analyse giraffe sighting data to\nlearn more about population numbers and\ntheir distribution.';
  static const String googleMapsKey = 'AIzaSyAOS3MNFRvay-EwaQcwBrJekSX2zwUI-2U';
  static const List<Map> drawerItems = [
    {
      'icon': Assets.donate,
      'title': 'Donation',
    },
    {
      'icon': Assets.home_heart,
      'title': 'Adoption',
    },
    {
      'icon': Assets.info_square,
      'title': 'About Us',
    },
    // {
    //   'icon': Assets.invite_friends,
    //   'title': 'Invite friends',
    // },
    {
      'icon': Assets.logout,
      'title': 'Log Out',
    },
    {
      'icon': Assets.deleteIcon,
      'title': 'Delete Account',
    },
  ];
  static List giraffes = [
    CardSlide(image: Assets.John, imageType: false, cardTitle: "John Doe", locationName: "Kenya", onTap: () => {}),
    CardSlide(image: Assets.Anne, imageType: false, cardTitle: "Anne Mary", locationName: "Mozambique", onTap: () => {}),
    CardSlide(image: Assets.Anne, imageType: false, cardTitle: "Anne Mary", locationName: "Mozambique", onTap: () => {})
  ];
  static final List regions = [
    Region(title: "Eastern Africa"),
    Region(title: "Western Africa"),
    Region(title: "Southern Africa"),
    Region(title: "Nothern Africa"),
  ];
  static final List parks = [
    Park(
      park: "Nairobi National Park",
      country: "Kenya",
      flag: "assets/images/Kenya.png",
    ),
    Park(
      park: "Nairobi National Park",
      country: "Libya",
      flag: "assets/images/Libya.png",
    ),
    Park(
      park: "Nairobi National Park",
      country: "Kenya",
      flag: "assets/images/Flag3.png",
    ),
    Park(
      park: "Nairobi National Park",
      country: "Kenya",
      flag: "assets/images/Flag4.png",
    )
  ];
  static final List notifications = [
    NotificationTile(
        image: "assets/images/Anne.png",
        feedback: "Upload Accepted",
        description: "The photo has been uploaded successfully.\nThank you for your contribution",
        status: true,
        time: "30m ago"),
    NotificationTile(
        image: "assets/images/John.png",
        feedback: "Upload Rejected",
        status: false,
        description: "The photo has been uploaded successfully.\nThank you for your contribution",
        time: "45m ago"),
    NotificationTile(
        image: "assets/images/Anne.png",
        status: false,
        feedback: "Upload Rejected",
        description: "The photos you uploaded were not suitable\nto identify the giraffe.",
        time: "1hr ago"),
    NotificationTile(
        image: "assets/images/Anne.png",
        feedback: "Upload Accepted",
        status: true,
        description: "The photo has been uploaded successfully.\nThank you for your contribution",
        time: "30m ago"),
    NotificationTile(
        image: "assets/images/John.png",
        feedback: "Upload Rejected",
        status: false,
        description: "The photos you uploaded were not suitable\nto identify the giraffe.",
        time: "3hr ago"),
    NotificationTile(
        image: "assets/images/Anne.png",
        feedback: "Upload Accepted",
        status: true,
        description: "The photo has been uploaded successfully.\nThank you for your contribution",
        time: "30m ago"),
    NotificationTile(
        image: "assets/images/Anne.png",
        feedback: "Upload Accepted",
        status: true,
        description: "The photo has been uploaded successfully.\nThank you for your contribution",
        time: "30m ago"),
    NotificationTile(
        image: "assets/images/Anne.png",
        feedback: "Upload Accepted",
        status: true,
        description: "The photo has been uploaded successfully.\nThank you for your contribution",
        time: "30m ago"),
    NotificationTile(
        image: "assets/images/Anne.png",
        feedback: "Upload Accepted",
        status: true,
        description: "The photo has been uploaded successfully.\nThank you for your contribution",
        time: "30m ago"),
    NotificationTile(
        image: "assets/images/Anne.png",
        feedback: "Upload Accepted",
        status: true,
        description: "The photo has been uploaded successfully.\nThank you for your contribution",
        time: "30m ago"),
    NotificationTile(
        image: "assets/images/Anne.png",
        feedback: "Upload Accepted",
        status: true,
        description: "The photo has been uploaded successfully.\nThank you for your contribution",
        time: "30m ago"),
    NotificationTile(
        image: "assets/images/John.png",
        feedback: "Upload Rejected",
        status: false,
        description: "The photos you uploaded were not suitable\nto identify the giraffe.",
        time: "3hr ago"),
  ];
}

import 'package:flutter/material.dart';

import 'Palette.dart';

class Styles {
  static TextStyle onBoardTopics =
      TextStyle(color: Palette.primaryTextColor, fontFamily: 'Poppins-SemiBold', fontSize: 40, letterSpacing: 0.35);
  static TextStyle onBoardSubTopics =
      TextStyle(color: Palette.secondaryTextColor, fontFamily: 'Poppins-Regular', fontSize: 16.5, height: 1.23, letterSpacing: -0.35);
  static TextStyle onBoardNext = TextStyle(color: Colors.white, fontFamily: 'Poppins-Bold', fontSize: 14, height: 1.36);
  static TextStyle onBoardSkip = TextStyle(color: Palette.accentColor, fontFamily: 'Poppins-Bold', fontSize: 14, height: 1);
  static TextStyle profileName = TextStyle(color: Palette.secondaryTextColor, fontFamily: 'Poppins-SemiBold', fontSize: 14, height: 1);
  static TextStyle profileEmail =
      TextStyle(color: Palette.secondaryTextColor.withOpacity(0.6), fontFamily: 'Poppins-Regular', fontSize: 12);
  static TextStyle menuItems = TextStyle(color: Palette.secondaryTextColor, fontFamily: 'Poppins-Regular', fontSize: 16);
  static TextStyle labelTextFormFieldTap = TextStyle(color: Palette.tertiaryColor, fontFamily: 'Poppins-Regular', fontSize: 12);
  static TextStyle labelTextFormField = TextStyle(color: Palette.secondaryTextColor, fontFamily: 'Poppins-Regular', fontSize: 12);
  static TextStyle spanText = TextStyle(color: Palette.tertiaryColor, fontFamily: 'Poppins-Regular', fontSize: 12);
  static TextStyle buttonText = TextStyle(color: Palette.primaryColor, fontFamily: 'Poppins-Bold', fontSize: 14);
  static TextStyle bannerTitle = TextStyle(fontFamily: 'Poppins-SemiBold', color: Palette.primaryTextColor, fontSize: 40);
  static TextStyle bannerSubTitle = TextStyle(fontFamily: 'Poppins-Regular', color: Palette.secondaryTextColor, fontSize: 16);
  static TextStyle appBarTitle = TextStyle(fontFamily: 'Poppins-SemiBold', color: Palette.primaryTextColor, fontSize: 22);
  static TextStyle bodyText = TextStyle(color: Palette.secondaryTextColor, fontFamily: 'Poppins-Regular', fontSize: 12, height: 2);
  static TextStyle viewAllTitle = TextStyle(fontFamily: 'Poppins-SemiBold', color: Palette.accentColor, fontSize: 10);
  static TextStyle cardSlideTitle = TextStyle(fontFamily: 'Poppins-Medium', color: Palette.primaryTextColor, fontSize: 14);
  static TextStyle locationTitle = TextStyle(fontFamily: 'Poppins-Medium', color: Palette.primaryTextColor, fontSize: 10);
  static TextStyle hintText = TextStyle(fontFamily: 'Poppins-Light', color: Palette.primaryTextColor.withOpacity(0.5), fontSize: 14);
  static TextStyle bottomNavigationLabel = TextStyle(fontFamily: 'Poppins-Medium', color: Palette.secondaryTextColor, fontSize: 10);
  static TextStyle selectedBottomNavigationLabel = TextStyle(fontFamily: 'Poppins-Medium', color: Palette.accentColor, fontSize: 10);
  static TextStyle cardTimeText = TextStyle(fontFamily: 'Poppins-ExtraLight', color: Palette.tertiaryColor, fontSize: 12);
  static TextStyle cardCategoryText = TextStyle(fontFamily: 'Poppins-Regular', fontSize: 12);
  static TextStyle articleBodyText = TextStyle(fontFamily: 'Poppins-Regular', color: Palette.secondaryTextColor, fontSize: 14);
  static TextStyle adoptText = TextStyle(fontFamily: 'Poppins-Bold', color: Palette.accentColor, fontSize: 14);
  static TextStyle dataText = TextStyle(fontFamily: 'Poppins-Bold', color: Palette.primaryTextColor, fontSize: 12);
  static TextStyle dataSubtitleText = TextStyle(fontFamily: 'Poppins-SemiBold', color: Palette.secondaryTextColor, fontSize: 8);
  static TextStyle watchVideoText = TextStyle(fontFamily: 'Poppins-SemiBold', color: Palette.tertiaryColor, fontSize: 14);
  static TextStyle notificationText = TextStyle(fontFamily: 'Poppins-Regular', color: Palette.secondaryTextColor, fontSize: 12);
  static TextStyle notificationDayText = TextStyle(fontFamily: 'Poppins-SemiBold', color: Palette.notificationDayColor, fontSize: 14);
  static TextStyle clearTextColor = TextStyle(fontFamily: 'Poppins-Light', color: Palette.tertiaryColor, fontSize: 14);
  static TextStyle messageTextColor = TextStyle(fontFamily: 'Poppins-Medium', color: Palette.secondaryTextColor, fontSize: 14, height: 1.6);
  static TextStyle warningTextColor = TextStyle(fontFamily: 'Poppins-SemiBold', color: Palette.warningColor, fontSize: 22);
  static TextStyle comeBackSoon = TextStyle(fontFamily: 'Poppins-SemiBold', color: Palette.primaryTextColor, fontSize: 16);
  static TextStyle logQuery = TextStyle(fontFamily: 'Poppins-Regular', color: Palette.secondaryTextColor, fontSize: 16);
  static TextStyle cancelModal = TextStyle(fontFamily: 'Poppins-Bold', color: Palette.accentColor, fontSize: 14);
  static TextStyle successTextColor = TextStyle(fontFamily: 'Poppins-SemiBold', color: Palette.successColor, fontSize: 22);
  static TextStyle aboutBodyTitleColor = TextStyle(fontFamily: 'Poppins-SemiBold', color: Palette.primaryTextColor, fontSize: 14);
  static TextStyle aboutBodyColor = TextStyle(fontFamily: 'Poppins-Regular', color: Palette.secondaryTextColor, fontSize: 14);
  static TextStyle regionsHeading = TextStyle(fontFamily: 'Poppins-Regular', color: Palette.secondaryTextColor, fontSize: 16);
  static TextStyle regions = TextStyle(fontFamily: 'Poppins-Regular', color: Palette.secondaryTextColor, fontSize: 14);
  static TextStyle park = TextStyle(fontFamily: 'Poppins-Regular', color: Palette.secondaryTextColor, fontSize: 14);
  static TextStyle country = TextStyle(fontFamily: 'Poppins-Regular', color: Palette.secondaryTextColor, fontSize: 12);
  static TextStyle mapSearchText =
      TextStyle(fontFamily: 'Poppins-SemiBold', color: Palette.primaryTextColor.withOpacity(0.5), fontSize: 12);
  static TextStyle pageTopic = TextStyle(color: Palette.primaryTextColor, fontFamily: 'Poppins-SemiBold', fontSize: 22);
  static TextStyle captureDetails = TextStyle(color: Palette.secondaryTextColor, fontFamily: 'Poppins-Regular', fontSize: 14, height: 1.4);
  static TextStyle captureDetailsLink = TextStyle(color: Palette.captureLink, fontFamily: 'Poppins-SemiBold', fontSize: 14);
  static TextStyle captureData = TextStyle(color: Palette.primaryTextColor, fontFamily: 'Poppins-SemiBold', fontSize: 16);
  static TextStyle captureCalendar = TextStyle(color: Palette.secondaryTextColor, fontFamily: 'Poppins-Regular', fontSize: 14);
  static TextStyle searchHint = TextStyle(color: Palette.searchColor, fontFamily: 'Poppins-Medium', fontSize: 14);
  static TextStyle uploadSuccessful =
      TextStyle(color: Palette.greenColor, fontFamily: 'Poppins-SemiBold', fontSize: 22, letterSpacing: 0.2);
  static TextStyle uploadSuccessfulDetails =
      TextStyle(color: Palette.secondaryTextColor, fontFamily: 'Poppins-Medium', fontSize: 14, height: 2.1);
  static TextStyle deleteAccount = TextStyle(color: Palette.redColor, fontFamily: 'Poppins-SemiBold', fontSize: 22);
  static TextStyle deleteAccountDetails =
      TextStyle(color: Palette.secondaryTextColor, fontFamily: 'Poppins-Regular', fontSize: 14, height: 1.3);
  static TextStyle deleteNote = TextStyle(color: Palette.primaryTextColor, fontFamily: 'Poppins-SemiBold', fontSize: 14, height: 0.7);
  static TextStyle confirmDeleteTopic = TextStyle(color: Palette.primaryTextColor, fontFamily: 'Poppins-SemiBold', fontSize: 16, height: 1);
  static TextStyle confirmDeleteW =
      TextStyle(color: Palette.primaryTextColor, fontFamily: 'Poppins-SemiBold', fontSize: 16, height: 0.3, letterSpacing: 0.25);
  static TextStyle confirmDeleteNote =
      TextStyle(color: Palette.primaryTextColor, fontFamily: 'Poppins-Regular', fontSize: 16, height: 0.3, letterSpacing: 0.25);
  static TextStyle confirmDeleteHere = TextStyle(color: Palette.captureLink, fontFamily: 'Poppins-Regular', fontSize: 14, height: 0.9);
  static TextStyle editProfileTopics =
      TextStyle(color: Palette.secondaryTextColor, fontFamily: 'Poppins-Regular', fontSize: 12, height: 0.9);
  static TextStyle editProfileInput = TextStyle(color: Palette.primaryTextColor, fontFamily: 'Poppins-Regular', fontSize: 16, height: 0.9);
  static TextStyle filterBy = TextStyle(color: Palette.primaryTextColor, fontFamily: 'Poppins-SemiBold', fontSize: 14);
  static TextStyle filterClear = TextStyle(color: Palette.tertiaryColor, fontFamily: 'Poppins-Thin', fontSize: 14);
  static TextStyle filterData = TextStyle(color: Palette.secondaryTextColor, fontFamily: 'Poppins-Regular', fontSize: 16);
  static TextStyle radioText = TextStyle(color: Palette.secondaryTextColor, fontFamily: 'Poppins-ExtraLight', fontSize: 14);
  static TextStyle rangeNumber = TextStyle(color: Palette.tertiaryColor, fontFamily: 'Poppins-SemiBold', fontSize: 16);
  static TextStyle doneCapture = TextStyle(color: Palette.accentColor, fontSize: 18, fontFamily: 'Poppins-semiBold');
  static TextStyle titlesCapture = TextStyle(color: Palette.secondaryTextColor, fontFamily: 'Poppins-Regular', fontSize: 12);
}

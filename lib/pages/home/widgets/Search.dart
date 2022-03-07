import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/FilterGiraffesCubit.dart';
import 'package:giraffe_spotter/blocs/home/articlesSearch/ArticleSearchCubit.dart';
import 'package:giraffe_spotter/blocs/videos/video_search/VideoSearchCubit.dart';
import 'package:giraffe_spotter/config/Decorations.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/models/Item.dart';
import 'package:giraffe_spotter/models/YoutubeVideo.dart';

class SearchField extends StatelessWidget {
  final List<Item>? dataItems;
  final List<Video>? videoList;
  final List?
  giraffeProfileList;
  final bool searchAndFilter;
  final String diffSearch;
  SearchField({this.dataItems, this.videoList,required this.diffSearch, this.giraffeProfileList, this.searchAndFilter = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key('searchField'),
      maxLines: 1,
      cursorWidth: 1.0,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      textDirection: TextDirection.ltr,
      cursorColor: Palette.secondaryTextColor,
      onChanged: (text) {
        //search from Item.title model data
        if (dataItems != null) context.read<ArticleSearchCubit>().retrieveTitle(dataItems, text);
        if (videoList != null) context.read<VideoSearchCubit>().searchVideo(videoList, text);
        if (searchAndFilter == true) context.read<FilterGiraffesCubit>().onSearchChanged(text);
      },
      decoration: Decorations.searchFieldDecoration(diffSearch),
      onEditingComplete: () {
        if (searchAndFilter == true) {
          context.read<FilterGiraffesCubit>().filterGiraffes();
        }
      },
    );
  }
}

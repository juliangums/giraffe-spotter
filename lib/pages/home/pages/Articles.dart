import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/home/articles/Bloc.dart';
import 'package:giraffe_spotter/blocs/home/articlesSearch/ArticleSearchCubit.dart';
import 'package:giraffe_spotter/models/Item.dart';
import 'package:giraffe_spotter/models/WelcomeJson.dart';
import 'package:giraffe_spotter/pages/home/widgets/GridViewWidget.dart';
import 'package:giraffe_spotter/pages/home/widgets/LoadingArticles.dart';
import 'package:giraffe_spotter/pages/home/widgets/Search.dart';
import 'package:giraffe_spotter/widgets/ArrowBackButton.dart';
import 'package:giraffe_spotter/widgets/PageWrapper.dart';


class Articles extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: "Articles",
      leading: ArrowBackButton(),
      child: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => LoadingPage(),
            idle: () => LoadingPage(),
            getFeedDone: (WelcomeJson data) => BlocProvider(
                  create: (context) => ArticleSearchCubit(dataItems: data.rss.channel.item),
                  child: BlocBuilder<ArticleSearchCubit, ArticleSearchState>(
                    buildWhen: (previous,current) => previous!=current,
                    builder: (context, state) {
                      return resultsPicker(context, state, data.rss.channel.item);
                    },
                  ),
                ),
            orElse: () => LoadingPage(),
          );
        },
      ),
    );
  }

  // build widget based on the results.
  StatelessWidget resultsPicker(BuildContext context, ArticleSearchState state, List<Item> data) {
    if (state is ErrorSearchState) {
      return LoadingPage();
    }
    else if (state is LoadingSearchState) {
      return LoadingPage();
    }
    else if (state is LoadedSearchState) {
      return Container (
        padding:EdgeInsets.symmetric(horizontal: 20),
        child: Column (
          mainAxisSize: MainAxisSize.min,
          children: [
            SearchField(dataItems: data, diffSearch: 'article'),
            GridViewWidget(dataItems: state.dataItems)
          ],
        ),
      );
    }
    else {
      return Container (
        padding:EdgeInsets.symmetric(horizontal: 20),
        child: Column (
          mainAxisSize: MainAxisSize.min,
          children: [
            SearchField(dataItems: data,diffSearch: 'article'),
            GridViewWidget(dataItems: data)
          ],
        ),
      );
    }
  }
}

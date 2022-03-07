part of 'ArticleSearchCubit.dart';

abstract class ArticleSearchState extends Equatable {
  const ArticleSearchState();
}

class InitialSearchState extends ArticleSearchState {
  @override
  List<Object> get props => [];
}

class LoadingSearchState extends ArticleSearchState{
  @override
  List<Object> get props => [];
}

class ErrorSearchState extends ArticleSearchState{
  @override
  List<Object> get props => [];
}

class LoadedSearchState extends ArticleSearchState{
  final List<Item> dataItems;
  //passing the item model data to the UI endpoint
  LoadedSearchState(this.dataItems);

  @override
  List<Object> get props => [dataItems];
}


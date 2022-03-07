import 'package:giraffe_spotter/models/GiraffeData.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/providers/BaseProvider.dart';
import 'package:giraffe_spotter/providers/FavouriteProvider.dart';

class FavouriteRespository{
  BaseFavouriteProvider favouriteProvider = FavouriteProvider();

  Future<ApiResult> favourites() => favouriteProvider.favourites();

  Future<ApiResult>  unFavourite(String id)=> favouriteProvider.unFavourite(id);

  Future<ApiResult>  addFavourite(String id)=> favouriteProvider.addFavourite(id);
}
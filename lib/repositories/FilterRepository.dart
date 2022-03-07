import 'package:giraffe_spotter/models/FilterFile.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/providers/BaseProvider.dart';
import 'package:giraffe_spotter/providers/FilterProvider.dart';
import 'package:giraffe_spotter/repositories/BaseRepository.dart';

class FilterRepository extends BaseRepository {

  final BaseFilterProvider _baseFilterProvider = FilterProvider();

  Future<ApiResult<FilterFile>> getConfig() => _baseFilterProvider.getConfig();

  @override
  void dispose() {}

}
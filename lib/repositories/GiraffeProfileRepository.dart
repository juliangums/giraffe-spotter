import 'package:giraffe_spotter/models/GiraffeData.dart';
import 'package:giraffe_spotter/models/GiraffeProfile.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/providers/GiraffeProfileProvider.dart';
import 'package:giraffe_spotter/repositories/BaseRepository.dart';

class GiraffeProfileRepository extends BaseRepository {
  final GiraffeProfileProvider _giraffeProfileProvider = GiraffeProfileProvider();

  Future<ApiResult<List<GiraffeData>>> getGiraffeProfiles({required int page}) => _giraffeProfileProvider.getGiraffeProfile(page);

  Future<ApiResult<List<GiraffeData>>> filteredGiraffes(
          {required String ageStart, required String ageEnd, required String species, required String location, required String gender}) =>
      _giraffeProfileProvider.filterGiraffes(ageStart: ageStart, ageEnd: ageEnd, species: species, location: location, gender: gender);

  Future<ApiResult<GiraffeData>> singleGiraffe({required String id}) => _giraffeProfileProvider.singleGiraffe(id: id);

  @override
  void dispose() {}
}

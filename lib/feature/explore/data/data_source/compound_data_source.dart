import 'package:dartz/dartz.dart';
import 'package:nawy_real_state/core/constant/urls.dart';
import 'package:nawy_real_state/core/network_structure/api_result_model.dart';
import 'package:nawy_real_state/feature/explore/data/model/compound_data_model.dart';
import 'package:nawy_real_state/feature/explore/data/model/location_data_model.dart';
import 'package:nawy_real_state/feature/explore/data/model/search_model.dart';

import '../../../../core/network_structure/api_service.dart';

class PropertyRemoteDataSource {
  Future<Either<String, ApiResult<CompoundDataModel>>> getCompounds() async {
    return await ApiService().callList<CompoundDataModel>(
      HttpMethod.get,
      Urls.compoundEndpoint,
      fromJsonItem: (json) => CompoundDataModel.fromJson(json),
    );
  }

  Future<Either<String, ApiResult<LocationModel>>> getAreas() async {
    return await ApiService().callList<LocationModel>(
      HttpMethod.get,
      Urls.areaEndPoint,
      fromJsonItem: (json) => LocationModel.fromJson(json),
    );
  }

  Future<Either<String, ApiResult<SearchResponse>>> search() async {
    return await ApiService.callObject<SearchResponse>(
      HttpMethod.get,
      Urls.propertiesSearchEndpoint,
      fromJson: (json) => SearchResponse.fromJson(json),
    );
  }
}

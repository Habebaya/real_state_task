import 'package:dartz/dartz.dart';
import 'package:nawy_real_state/core/constant/urls.dart';
import 'package:nawy_real_state/core/network_structure/api_result_model.dart';
import 'package:nawy_real_state/feature/explore/data/model/property_filter/property_filter_model.dart';

import '../../../../core/network_structure/api_service.dart';

class FilterRemoteDataSource {
  Future<Either<String, ApiResult<PropertyFilterModel>>>
  getFilterProperties() async {
    return await ApiService.callObject<PropertyFilterModel>(
      HttpMethod.get,
      Urls.propertiesFilterEndpoint,
      fromJson: (json) => PropertyFilterModel.fromJson(json),
    );
  }
}

import 'package:get_it/get_it.dart';
import 'package:nawy_real_state/feature/explore/data/data_source/compound_data_source.dart';
import 'package:nawy_real_state/feature/explore/data/data_source/filter_data_source.dart';
import 'package:nawy_real_state/feature/explore/presentation/manger/browse_cubit.dart';
import 'package:nawy_real_state/feature/explore/presentation/manger/search/search_cubit.dart';

final GetIt getIt = GetIt.instance;

class ServiceLocator {
  dynamic init() async {
    //otp
    getIt.registerLazySingleton<PropertyRemoteDataSource>(
      () => PropertyRemoteDataSource(),
    );
    getIt.registerLazySingleton<FilterRemoteDataSource>(
      () => FilterRemoteDataSource(),
    );

    getIt.registerFactory<BrowseCubit>(() => BrowseCubit(getIt()));
    getIt.registerFactory<SearchCubit>(() => SearchCubit(getIt(), getIt()));
  }
}

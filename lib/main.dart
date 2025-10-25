import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nawy_real_state/config/theme/app_color.dart';
import 'package:nawy_real_state/feature/explore/presentation/manger/browse_cubit.dart';
import 'package:nawy_real_state/feature/explore/presentation/manger/search/search_cubit.dart';

import 'config/routes/route_service.dart';
import 'core/service/property_hive_store.dart';
import 'core/service_locator.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  // Open UNTYPED box (no generic, no adapter)
  if (!Hive.isBoxOpen(PropertyHiveStore.boxName)) {
    await Hive.openBox(PropertyHiveStore.boxName);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  await ScreenUtil.ensureScreenSize();
  await ServiceLocator().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      designSize: Size(360, 681),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BrowseCubit>(
            create: (context) => BrowseCubit(getIt())
              ..fetchCompounds()
              ..fetchAreas(),
          ),
          BlocProvider<SearchCubit>(
            create: (context) => SearchCubit(getIt(), getIt()),
          ),
        ],
        child: MaterialApp.router(
          title: 'Nawy Task',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.scaffoldBackgroundColor,
            ),
          ),
          routerConfig: RouteService.goRouter,
        ),
      ),
    );
  }
}

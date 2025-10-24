import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/routes/route_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      designSize: const Size(375, 812),
      child: MaterialApp.router(
        title: 'Nawy Task',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        routerConfig: RouteService.goRouter,
      ),
    );
  }
}

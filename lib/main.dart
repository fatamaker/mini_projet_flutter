import 'package:flutter/material.dart';
import 'package:flutter_application_ngrk/presentation/controllers/article_controller.dart';
import 'package:flutter_application_ngrk/presentation/controllers/order_controller.dart';
import 'package:flutter_application_ngrk/presentation/screens/HomePage.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'di.dart' as di;

void main() async {
  await di.init();
  Get.put(OrderController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(ArticleController());
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false, // Ajoute cette ligne
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
            ),
            home: HomePage(),
          );
        });
  }
}

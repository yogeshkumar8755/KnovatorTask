import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/List_of_post.dart';
import 'screens/controller/post_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialBinding: BindingsBuilder(() {
          Get.put(PostController());
        }),
        home: ListOfScreen());
  }
}

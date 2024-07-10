import 'package:flutter/material.dart';
import 'package:galaxy_app/provider/home_provider.dart';
import 'package:galaxy_app/view/detail_page.dart';
import 'package:galaxy_app/view/favorite_page.dart';
import 'package:galaxy_app/view/home_page.dart';
import 'package:galaxy_app/view/splash_page.dart';
import 'package:provider/provider.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          routes: {
            "/": (context) => SplashScreen(),
            "home_page": (context) => HomePage(),
            "detail_page": (context) => DetailPage(),
            "favorite_page": (context) => FavoritesPage(),
          },
        );
      },
    );
  }
}

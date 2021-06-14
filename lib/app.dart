import 'package:aj_ar/Provider/ArchiProvider.dart';
import 'package:aj_ar/Provider/Auth.dart';
import 'package:aj_ar/Screen/ArScreen.dart';
import 'package:aj_ar/Screen/BuildersPage.dart';
import 'package:aj_ar/Screen/CategoryScreen.dart';
import 'package:aj_ar/Screen/DetailedScreen.dart';
import 'package:aj_ar/Screen/SearchResults.dart';
import 'package:aj_ar/Screen/BuilderScreen.dart';
import 'package:aj_ar/Screen/Settings.dart';
import 'package:aj_ar/Screen/Stepper.dart';
import 'package:aj_ar/Screen/TransformNode.dart';
import 'package:aj_ar/Screen/loginScreen.dart';
import 'package:aj_ar/Theme/MyThem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/BuilderProvider.dart';
import 'Screen/Gallery.dart';
import 'Screen/HomeScreen.dart';
import 'Screen/PageView.dart';

class App extends StatelessWidget {
  static String routeName = '/app';
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ArchiProvider>(
          create: (_) => null,
          update: (context, auth, previousproduct) => ArchiProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, BuilderProvider>(
          create: (_) => null,
          update: (context, auth, previousproduct) => BuilderProvider(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, child) => MaterialApp(
          theme: MyTheme.lightTheme,
          home: auth.isAuth ? MyPageView() : LoginScreen(),
          routes: {
            HomeScrenn.routeName: (ctx) => HomeScrenn(),
            DetailedScreen.routeName: (ctx) => DetailedScreen(),
            BuilderScreen.routeName: (ctx) => BuilderScreen(),
            CategoryScreen.routeName: (ctx) => CategoryScreen(),
            MySettings.routeName: (ctx) => MySettings(),
            Gallery.routeName: (ctx) => Gallery(),
            ArScreen.routeName: (ctx) => ArScreen(),
            TransformableNodeScreen.routeName: (ctx) =>
                TransformableNodeScreen(),
            BuildersPage.routeName: (ctx) => BuildersPage(),
            StepperDemo.routeName: (ctx) => StepperDemo(),
            SearchResults.routeName: (ctx) => SearchResults(),
          },
        ),
      ),
    );
  }
}

import 'package:Eventory/screens/home.dart';
import 'package:Eventory/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:Eventory/services/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:Eventory/providers/app_provider.dart';
import 'package:Eventory/util/const.dart';
import 'package:Eventory/screens/splash.dart'; //destination
import 'package:Eventory/screens/profile.dart';




void main() {
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, Widget child) {
        return MaterialApp(
          key: appProvider.key,
          debugShowCheckedModeBanner: false,
          navigatorKey: appProvider.navigatorKey,
          title: Constants.appName,
          theme: appProvider.theme,
          home: SplashScreen(),
           routes: <String,WidgetBuilder>{
          '/Supplier': (BuildContext context)=> new MainScreen(),
          '/Client': (BuildContext context)=> new Profile(),
          '/LoginScreen': (BuildContext context)=> new LoginScreen(),
      },
        );
      },
    );
  }
}
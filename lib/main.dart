import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodgame/Navigations/navigator.dart';
import 'package:foodgame/pages/first_page.dart';
import 'package:foodgame/pages/second_page.dart';

void main() {

   WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      // home:   SecondPage()


       initialRoute: FirstPage.first_page,
       routes: navigations,
    );
  }
}




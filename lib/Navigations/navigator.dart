import 'package:flutter/material.dart';
import 'package:foodgame/pages/first_page.dart';
import 'package:foodgame/pages/fourth_page.dart';
import 'package:foodgame/pages/second_page.dart';
import 'package:foodgame/pages/third_page.dart';

Map<String, Widget Function(BuildContext)> navigations = {

  
  FirstPage.first_page: (context) => FirstPage(),
  SecondPage.second_page: (context) => SecondPage(),
  
ThirdPage.thirdpage: (context) {
  final ThirdPage thirdPage = ThirdPage(onPageRefresh: () {  },);
  thirdPage.resetState(); 
  return thirdPage;
},



  Fourthpage.fourth_page: (context) => const Fourthpage(),
};

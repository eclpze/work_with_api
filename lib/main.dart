import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:work_with_api/globals.dart';
import 'package:work_with_api/sections/facts.dart';
import 'package:work_with_api/sections/food.dart';
import 'package:work_with_api/sections/map.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initPrefs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: page);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: bottomNavigationKey,
        index: page,
        height: 70,
        items: [
          Icon(Icons.map, size: 30),
          Icon(Icons.pets, size: 30),
          Icon(Icons.fastfood, size: 30),
          Icon(Icons.list, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Color(0xffF2F2F2),
        backgroundColor: Color(0xffDDDDDD),
        animationCurve: Curves.easeIn,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            page = index;
          });
          animatePage();
        },
        letIndexChange: (index) => true,
      ),
      body: PageView(controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        setState(() {
          page = index;
        });
      },
      children: [
        MapPage(), Facts(), Food(), Facts(),
      ],),
    );
  }
}


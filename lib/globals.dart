import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_with_api/data.dart';

var network = Network();
late SharedPreferences prefs;
int page = 0;
GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

TextEditingController addressController = TextEditingController();
PageController pageController = PageController();
MapController mapController = MapController();

void animatePage() {
  if (pageController.hasClients) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }
}

void initPrefs() async {
  prefs = await SharedPreferences.getInstance();
}

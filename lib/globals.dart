import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_with_api/data.dart';

var network = Network();
TextEditingController addressController = TextEditingController();
MapController mapController = MapController();
late SharedPreferences prefs;

void initPrefs() async {
  prefs = await SharedPreferences.getInstance();
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:work_with_api/globals.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final String? getLat;
  late final String? geoLon;
  bool isLoading = false;

  void getAddress() async {
    setState(() {
      isLoading = true;
    });

    try {
      var response = await network.postAddress(addressController.text);

      if (response['status'] == 'ok') {
        var address = jsonDecode(response['data'].body.replaceAll('/', ''));

        if (address[0]['geo_lat'] != null && address[0]['geo_lon'] != null) {
          String geoLat = address[0]['geo_lat'];
          String geoLon = address[0]['geo_lon'];

          await prefs.setString('getLat', geoLat);
          await prefs.setString('geoLon', geoLon);

          final String? geoLatGet = prefs.getString('getLat');
          final String? geoLonGet = prefs.getString('geoLon');

          if (geoLatGet != null && geoLonGet != null) {
            mapController.move(
              LatLng(double.parse(geoLatGet), double.parse(geoLonGet)),
              17,
            );
          }
        }
      }
    } catch (e) {
      print('Ошибка получения координат');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Ошибка получения координат',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            isLoading
                ? SizedBox(
                    height: 620,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xffC91C1C),
                      ),
                    ),
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 620,
                    child: FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        initialZoom: 9.2,
                        initialCenter: const LatLng(55.7522, 37.6156),
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: '',
                        ),
                        RichAttributionWidget(
                          attributions: [
                            TextSourceAttribution(
                              'OpenStreetMap contributors',
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
            Container(
              padding: EdgeInsets.all(24),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: Offset(0, 1),
                    color: Colors.black.withOpacity(.1),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Поиск',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1E1E1E),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: addressController,
                    cursorColor: Color(0xff1E1E1E),
                    decoration: InputDecoration(
                      fillColor: Color(0xffF2F2F2),
                      filled: true,
                      hintText: 'Введите адрес',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color(0xffA1A1A1),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color(0xffF2F2F2)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color(0xffF2F2F2)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color(0xffF2F2F2)),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(335, 58),
                        backgroundColor: Color(0xffC91C1C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      onPressed: isLoading
                          ? null
                          : () {
                              if (addressController.text.isNotEmpty) {
                                getAddress();
                                print('Координаты получены!');
                              } else {
                                print('Ошибка!');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(milliseconds: 1500),
                                    content: Text(
                                      'Введите адрес',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                      child: Text(
                        isLoading ? 'Загрузка...' : 'Проверить',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

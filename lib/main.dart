import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:work_with_api/data.dart';
import 'package:work_with_api/globals.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initPrefs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MapPage());
  }
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final String? getLat;
  late final String? geoLon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 670,
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialZoom: 9.2,
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
                          onTap: () {}
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
                      onPressed: () {
                        if (addressController.text.isNotEmpty) {
                          getAddress();
                          print('Координаты получены!');
                        } else {
                          print('Ошибка!');
                        }
                      },
                      child: Text(
                        'Проверить',
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

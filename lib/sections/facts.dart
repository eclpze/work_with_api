import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:work_with_api/globals.dart';

class Facts extends StatefulWidget {
  const Facts({super.key});

  @override
  State<Facts> createState() => _FactsState();
}

class _FactsState extends State<Facts> {
  String dogFact = prefs.getString('factDog') ?? 'Ничего не найдено :(';
  String catFact = prefs.getString('factCat') ?? 'Ничего не найдено :(';
  String imageFox = prefs.getString('imageFox') ?? '';
  String imageDog = prefs.getString('imageDog') ?? '';

  void getFactsDogs() async {
    var response = await network.getFactsDogs();

    if (response['status'] == 'ok') {
      var facts = jsonDecode(response['data'].body);

      String fact = facts['data'][0]['attributes']['body'];
      print('Факт про собак: ' + fact);

      await prefs.setString('factDog', fact);

      setState(() {
        dogFact = fact;
      });
    }
  }

  void getFactsCats() async {
    var response = await network.getFactsCats();

    if (response['status'] == 'ok') {
      var facts = jsonDecode(response['data'].body);

      String fact = facts['data'][0];
      print('Факт про кошек: ' + fact);

      await prefs.setString('factCat', fact);

      setState(() {
        catFact = fact;
      });
    }
  }

  void getImagesFox() async {
    var response = await network.getImagesFox();

    if (response['status'] == 'ok') {
      var images = jsonDecode(response['data'].body);

      String urlImage = images['image'];
      print(urlImage);

      await prefs.setString('imageFox', urlImage);

      setState(() {
        imageFox = urlImage;
      });
    }
  }

  void getImagesDog() async {
    var response = await network.getImagesDog();

    if (response['status'] == 'ok') {
      var images = jsonDecode(response['data'].body);

      String urlImage = images['url'];
      print(urlImage);

      await prefs.setString('imageDog', urlImage);

      setState(() {
        imageDog = urlImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 60),
              Text(
                'Факт про собак',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1E1E1E),
                ),
              ),
              SizedBox(height: 20),
              Text(
                dogFact,
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff1E1E1E),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(335, 58),
                  backgroundColor: Color(0xffC91C1C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onPressed: () {
                  getFactsDogs();
                },
                child: Text(
                  'Гав-гав',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Факт про кошек',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1E1E1E),
                ),
              ),
              SizedBox(height: 20),
              Text(
                catFact,
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff1E1E1E),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(335, 58),
                  backgroundColor: Color(0xffC91C1C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onPressed: () {
                  getFactsCats();
                },
                child: Text(
                  'Мяу-мяу',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Text(
                'Изображение лисы',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1E1E1E),
                ),
              ),
              SizedBox(height: 20),
              CachedNetworkImage(
                imageUrl: imageFox,
                placeholder: (context, url) => CircularProgressIndicator(
                  color: Colors.black,
                  padding: EdgeInsets.all(30),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(335, 58),
                  backgroundColor: Color(0xffC91C1C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onPressed: () {
                  getImagesFox();
                },
                child: Text(
                  'Фыр-фыр',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Text(
                'Изображение собаки',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1E1E1E),
                ),
              ),
              SizedBox(height: 20),
              CachedNetworkImage(
                imageUrl: imageDog,
                placeholder: (context, url) => CircularProgressIndicator(
                  color: Colors.black,
                  padding: EdgeInsets.all(30),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              // CachedNetworkImage(
              //   height: 100,
              //   width: 100,
              //   imageUrl: imageDog,
              //   progressIndicatorBuilder: (context, url, downloadProgress) {
              //     print(
              //       downloadProgress.downloaded.toString() +
              //           '/' +
              //           downloadProgress.totalSize.toString(),
              //     );
              //     return CircularProgressIndicator(
              //       value: downloadProgress.progress,
              //     );
              //   },
              //   errorWidget: (context, url, error) => Icon(Icons.error),
              // ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(335, 58),
                  backgroundColor: Color(0xffC91C1C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onPressed: () {
                  getImagesDog();
                },
                child: Text(
                  'Гав-гав',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

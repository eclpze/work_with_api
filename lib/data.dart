import 'package:http/http.dart' as http;

class Network {
  String token = 'Token 23b3221318705144da55c3ee85b51008ec1efacb';
  String key = 'a13b35def2708280b7d5e14d08d1836e25ce0904';

  Future postAddress(String address) async {
    http.Response response = await http.post(
      Uri.parse('https://cleaner.dadata.ru/api/v1/clean/address'),
      body: '[ "$address" ]',
      headers: {
        'Authorization': token,
        'X-Secret': key,
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    try {
      if (response.statusCode == 200) {
        print('Координаты получены');
        return {'data': response, 'status': 'ok'};
      } else {
        print('Ошибка!');
        return {'status': 'error', 'msg': response.body};
      }
    } catch (e) {
      print('Проблемы с Интернетом!');
      return {'status': 'error', 'msg': 'no internet'};
    }
  }

  Future getFactsDogs() async {
    http.Response response = await http.get(
      Uri.parse('https://dogapi.dog/api/v2/facts'),
    );

    try {
      if (response.statusCode == 200) {
        print('Факт о собаках получен');
        return {'data': response, 'status': 'ok'};
      } else {
        print('Ошибка!');
        return {'status': 'error', 'msg': response.body};
      }
    } catch (e) {
      print('Проблемы с Интернетом!');
      return {'status': 'error', 'msg': 'no internet'};
    }
  }

  Future getFactsCats() async {
    http.Response response = await http.get(
      Uri.parse('https://meowfacts.herokuapp.com'),
    );

    try {
      if (response.statusCode == 200) {
        print('Факт о кошках получен');
        return {'data': response, 'status': 'ok'};
      } else {
        print('Ошибка!');
        return {'status': 'error', 'msg': response.body};
      }
    } catch (e) {
      print('Проблемы с Интернетом!');
      return {'status': 'error', 'msg': 'no internet'};
    }
  }

  Future getImagesFox() async {
    http.Response response = await http.get(Uri.parse('https://randomfox.ca/floof/'));

    try {
      if (response.statusCode == 200) {
        print('Изображение лисы получено');
        return {'data': response, 'status': 'ok'};
      } else {
        print('Ошибка!');
        return {'status': 'error', 'msg': response.body};
      }
    } catch (e) {
      print('Проблемы с Интернетом!');
      return {'status': 'error', 'msg': 'no internet'};
    }
  }

  Future getImagesDog() async {
    http.Response response = await http.get(Uri.parse('https://random.dog/woof.json'));

    try {
      if (response.statusCode == 200) {
        print('Изображение собаки получено');
        return {'data': response, 'status': 'ok'};
      } else {
        print('Ошибка!');
        return {'status': 'error', 'msg': response.body};
      }
    } catch (e) {
      print('Проблемы с Интернетом!');
      return {'status': 'error', 'msg': 'no internet'};
    }
  }


}

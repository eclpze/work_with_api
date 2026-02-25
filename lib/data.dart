import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:work_with_api/globals.dart';
import 'package:latlong2/latlong.dart';

class Network {
  String url = 'https://cleaner.dadata.ru/api/v1/clean/address';
  String token = 'Token 23b3221318705144da55c3ee85b51008ec1efacb';
  String key = 'a13b35def2708280b7d5e14d08d1836e25ce0904';

  Future postAddress(String address) async {
    http.Response response = await http.post(
      Uri.parse(url),
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
        return {'data': response, 'status': 'ok'};
      } else {
        return {'status': 'error', 'msg': response.body};
      }
    } catch (e) {
      return {'status': 'error', 'msg': 'no internet'};
    }
  }
}

void getAddress() async {
  var response = await network.postAddress(addressController.text);
  var address = jsonDecode(response['data'].body.replaceAll('/', ' '));

  String geoLat = address[0]['geo_lat'];
  String geoLon = address[0]['geo_lon'];

  await prefs.setString('getLat', geoLat);
  await prefs.setString('geoLon', geoLon);

  final String? geoLatGet = prefs.getString('getLat');
  final String? geoLonGet = prefs.getString('geoLon');

  mapController.move(LatLng(double.parse(geoLatGet!), double.parse(geoLonGet!)), 17);


}

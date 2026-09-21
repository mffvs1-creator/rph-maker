import 'package:rpgmaker/api/classe.dart';
import 'package:dio/dio.dart';

class racepi {
 final dio = Dio();
 String baseUrl = 'https://www.dnd5eapi.co/api';

 findByraca(String raca) async {
  late Persoapi persoapi;
  final response = await dio.get('$baseUrl/ws/$raca/json/');

  if (response.statusCode == 200) {
   persoapi = Persoapi.fromJson(response.data);
  }

  return persoapi;
 }
}
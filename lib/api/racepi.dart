import 'package:rpgmaker/api/raca.dart';
import 'package:dio/dio.dart';

class racepi {
 final dio = Dio();
 String baseUrl = 'https://www.dnd5eapi.co/api';

 findByraca(String raca) async {
  late Raca racapi;
  final response = await dio.get('$baseUrl/ws/$raca/json/');

  if (response.statusCode == 200) {
   racapi = Raca.fromJson(response.data);
  }

  return racapi;
 }
}
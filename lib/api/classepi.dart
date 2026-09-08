import 'package:rpgmaker/api/persoapi.dart';
import 'package:dio/dio.dart';

class classepi {
  final dio = Dio();
  String baseUrl = 'https://www.dnd5eapi.co/api/2014/classes';

  findByCep(String classe) async {
    late Persoapi persoapi;
    final response = await dio.get('$baseUrl/ws/$classe/json/');

    if (response.statusCode == 200) {
      persoapi = Persoapi.fromJson(response.data);
    }

    return persoapi;
  }
  }
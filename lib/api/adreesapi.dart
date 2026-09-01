import 'package:rpgmaker/persona5/adress.dart';
import 'package:dio/dio.dart';

class AddressApi {
 final dio = Dio();
 String baseUrl = 'https://www.dnd5eapi.co/api';

 findByCep(String cep) async {
  late Adress adress;
  final response = await dio.get('$baseUrl/ws/$cep/json/');

  if (response.statusCode == 200) {
   Adress = adress.fromJson(response.data);
  }

  return Adress();
 }
}
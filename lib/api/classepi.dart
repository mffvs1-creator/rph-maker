import 'package:rpgmaker/api/classe.dart';
import 'package:dio/dio.dart';

class ClasseApi {
  final dio = Dio();
  String baseUrl = 'https://www.dnd5eapi.co/api';

  Future<List<Classe>> listarClasses() async {
    List<Classe> classes = [];
    final response = await dio.get('$baseUrl/2014/classes');

    if (response.statusCode == 200) {
      var dados = response.data.results;
      if (dados is List) {
        for (var item in response.data) {
          classes.add(Classe.fromJson(item));
        }
      }
    }

    return classes;
  }
  }
import 'package:rpgmaker/api/classe.dart';
import 'package:dio/dio.dart';

class ClasseApi {
  final dio = Dio();
  final String baseUrl = 'https://www.dnd5eapi.co/api';

  Future<List<Classe>> listarClasses() async {
    final response = await dio.get('$baseUrl/2014/classes');

    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>?;
      final results = data?['results'] as List<dynamic>? ?? <dynamic>[];

      return results.map((item) {
        if (item is Map<String, dynamic>) {
          return Classe.fromJson(item);
        }
        return Classe(
          index: '0',
          name: item.toString(),
          url: '',
        );
      }).toList();
    }

    return [];
  }
}
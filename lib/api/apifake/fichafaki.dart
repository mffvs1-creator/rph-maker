import 'package:dio/dio.dart';
import 'package:rpgmaker/persona5/ficha_model.dart';

class FichaApiFake {
  final Dio _dio = Dio();

  static const String _url =
      'https://raw.githubusercontent.com/jgs-if/fakeapi/main/fichaapi.json';


  Future<List<FichasP>> listarFichasExemplo() async {
    try {
      final response = await _dio.get(_url);

      final data = response.data;
      final List list = data is List ? data : (data?['fichas'] as List? ?? []);

      return list
          .map((json) => FichasP.fromMap(json as Map<String, dynamic>))
          .toList();
    } on DioException {
      return [];
    } catch (_) {
      return [];
    }
  }
}

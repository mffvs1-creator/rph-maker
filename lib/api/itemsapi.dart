import 'package:dio/dio.dart';
import 'package:rpgmaker/api/items.dart';

class ItemsApi {
  final Dio _dio = Dio();

  static const String _host = 'X-RapidAPI-Key';
  static const String _baseUrl = 'https://$_host';
  static const String _apiKey = '0cb8861846msh325b73c02155d38p1954f6jsn8572617758de';


  Future<Items?> findByName(String name) async {
    final options = Options(
      headers: {
        'x-rapidapi-key': _apiKey,
        'x-rapidapi-host': _host,
      },
    );

    try {

      final response = await _dio.get(
        '$_baseUrl/item',
        queryParameters: {'name': name},
        options: options,
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        
        final itemJson = data is List
            ? (data.isNotEmpty ? data.first as Map<String, dynamic> : null)
            : data as Map<String, dynamic>;

        if (itemJson != null) {
          return Items.fromJson(itemJson);
        }
      }
    } on DioException {
      return null;
    } catch (_) {
      return null;
    }

    return null;
  }
}

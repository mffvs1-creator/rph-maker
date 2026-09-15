import 'package:dio/dio.dart';
import 'package:rpgmaker/api/apifake/items.dart';

/// Talks to the "RPG Items" API on RapidAPI
/// (https://rapidapi.com/Rhatcher94/api/rpg-items).
///
/// IMPORTANT — fill these two in before this will work:
///   1. Open the API on RapidAPI -> Endpoints tab -> pick the endpoint you
///      want (e.g. "get item by name/id").
///   2. Click "Code Snippets" -> any language -> copy the request URL and
///      the `X-RapidAPI-Host` header value shown there, then paste them
///      into [_host] and the path used in [findByName] below.
///
/// The values below are placeholders based on the typical RapidAPI naming
/// convention for this listing and may not match the real endpoint path
/// or query parameter name — RapidAPI's docs are JS-rendered so they
/// couldn't be scraped automatically. Swap them for the real ones from
/// your dashboard.
class ItemsApi {
  final Dio _dio = Dio();

  static const String _host = 'X-RapidAPI-Key';
  static const String _baseUrl = 'https://$_host';
  static const String _apiKey = '0cb8861846msh325b73c02155d38p1954f6jsn8572617758de';

  /// Looks up a single item by name (or id, depending on the endpoint you
  /// wire up). Returns null if not found or if the request fails.
  Future<Items?> findByName(String name) async {
    final options = Options(
      headers: {
        'x-rapidapi-key': _apiKey,
        'x-rapidapi-host': _host,
      },
    );

    try {
      // TODO: adjust the path ('/item') and query param name ('name') to
      // match the endpoint you copied from RapidAPI's Code Snippets tab.
      final response = await _dio.get(
        '$_baseUrl/item',
        queryParameters: {'name': name},
        options: options,
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        // Some RapidAPI endpoints return a single object, others return a
        // list of matches — handle both so the UI doesn't need to care.
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

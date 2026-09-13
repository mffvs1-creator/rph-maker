import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utilidades/missao_model.dart';

class ApiMissoes {
  final String url = 'https://6aa6b4dfd7765db985078a40.mockapi.io/missoes';

  Future<List<Missao>> buscarMissoes() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print('Dados recebidos da API: ${response.body}');
        dynamic recheado = json.decode(response.body);

        if (recheado is List && recheado.isNotEmpty && recheado[0] is List) {
          recheado = recheado[0];
        }

        if (recheado is List) {
          return recheado.map((item) {
            if (item is Map<String, dynamic>) {
              return Missao.fromJson(item);
            } else {
              return Missao(id: '', titulo: 'Erro no Item', recompensa: '', dificulte: '');
            }
          }).toList();
        } else {
          throw Exception('A API não retornou uma lista');
        }
      } else {
        throw Exception('Falha ao carregar missões');
      }
    } catch (e) {
      print('Erro API: $e');
      throw Exception('Erro de conexão com o servidor');
    }
  }
}

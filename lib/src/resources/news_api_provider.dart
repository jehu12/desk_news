import 'dart:async';
import 'resources.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/models.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_root/topstories.json');

    if (response.statusCode == 200) {
      final ids = json.decode(response.body);

      return ids.cast<int>();
    } else {
      throw Exception('Failed to load top stories');
    }
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_root/item/$id.json');

    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load news');
    }
  }
}

import '../models/models.dart';
import 'resources.dart';
import 'dart:async';

class Repository {
  List<Source> sources = <Source>[
    NewsApiProvider(),
    newsDbProvider,
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  //Iterate over sources when dbProvider get fetchTopIds implemented
  Future<List<int>> fetchTopIds() async {
    return sources[0].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    var source;
    ItemModel itemModel;

    for (source in sources) {
      itemModel = await source.fetchItem(id);
      if (itemModel != null) {
        break;
      }
    }

    for (var cache in caches) {
      if (cache != source) {
        cache.addItem(itemModel);
      }
    }

    return itemModel;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
}

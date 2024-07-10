import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Item {
  final String image;
  final String name;
  final String type;

  Item({
    required this.image,
    required this.name,
    required this.type,
  });
}


class HomeProvider extends ChangeNotifier {
  List glist = [];

  void jfun() async {
    String data = await rootBundle.loadString("assets/galaxy.json");
    Map<String, dynamic> jdata = jsonDecode(data);
    glist = jdata["galaxy"];
    notifyListeners();
  }

  List<Item> _favoriteItems = [];

  List<Item> get favoriteItems => _favoriteItems;

  void toggleFavorite(Item item) {
    if (_favoriteItems.contains(item)) {
      return null;
    } else {
      _favoriteItems.add(item);
    }
    notifyListeners();
  }

  bool isFavorite(Item item) {
    return _favoriteItems.contains(item);
  }
  void removeFavorite(Item item) {
    _favoriteItems.remove(item);
    notifyListeners();
  }
}
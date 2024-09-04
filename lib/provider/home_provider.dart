import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Item {
  final String image;
  final String name;
  final String type;
  final String description;
  final Map<String, dynamic> gravity;
  final Map<String, dynamic> diameter;
  final Map<String, dynamic> mass;

  Item({
    required this.image,
    required this.name,
    required this.type,
    required this.description,
    required this.gravity,
    required this.diameter,
    required this.mass,
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
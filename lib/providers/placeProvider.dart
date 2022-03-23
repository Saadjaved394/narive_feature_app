import 'package:flutter/cupertino.dart';
import '../models/places.dart';
import 'dart:io';
import '../helpers/db_helper.dart';

class PlaceProvider with ChangeNotifier {
    List<Places> _items = [];

  List<Places> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle,
      File pickedImage,) {
    final newPlace = Places(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,

    });

  }
  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Places(
        id: item['id'],
        title: item['title'],
        image: File(item['image']),
        location: null,
      ),
    )
        .toList();
    notifyListeners();
  }
}

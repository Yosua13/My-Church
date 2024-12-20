import 'package:flutter/material.dart';
import 'package:proyek_akhir/models/church_model.dart';

class FavoriteChurchesProvider with ChangeNotifier {
  final List<ChurchModel> _favoriteChurches = [];

  List<ChurchModel> get favoriteChurches => _favoriteChurches;

  /// add favorite
  void addFavorite(ChurchModel church) {
    _favoriteChurches.add(church);
    notifyListeners();
  }

  /// remove favorite
  void removeFavorite(ChurchModel church) {
    _favoriteChurches.remove(church);
    notifyListeners();
  }
}

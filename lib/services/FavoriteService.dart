import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _key = 'favorite_stocks';

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  static Future<void> toggleFavorite(String symbol) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites =
    prefs.getStringList(_key) != null
        ? prefs.getStringList(_key)!
        : [];

    if (favorites.contains(symbol)) {
      favorites.remove(symbol);
    } else {
      favorites.add(symbol);
    }

    await prefs.setStringList(_key, favorites);
  }

  static Future<bool> isFavorite(String symbol) async {
    final favorites = await getFavorites();
    return favorites.contains(symbol);
  }
}
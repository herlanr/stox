import 'package:flutter/material.dart';
import '../models/stock.dart';
import '../services/FavoriteService.dart';
import '../services/StockService.dart';
import 'company_details.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final StockService _stockService = StockService();
  List<Stock> _favoriteStocks = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favorites = await FavoritesService.getFavorites();
    final allStocks = await _stockService.loadStocks();

    //used to update the UI
    setState(() {
      _favoriteStocks = allStocks.where((stock) {
        final isFav = favorites.contains(stock.symbol);
        stock.isFavorite = isFav;
        return isFav;
      }).toList();
    });
  }

  void _toggleFavorite(int index) async {
    final stock = _favoriteStocks[index];
    await FavoritesService.toggleFavorite(stock.symbol);

    setState(() {
      _favoriteStocks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: _favoriteStocks.isEmpty
          ? const Center(child: Text("No favorites yet"))
          : ListView.builder(
        itemCount: _favoriteStocks.length,
        itemBuilder: (context, index) {
          final stock = _favoriteStocks[index];
          return ListTile(
            title: Text(stock.name),
            subtitle: Text("${stock.symbol} • ${stock.country}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("\$${stock.price.toStringAsFixed(2)}"),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.red,
                  ),
                  onPressed: () => _toggleFavorite(index),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CompanyDetailsPage(stock: stock),
                ),
              ).then((_) => _loadFavorites());
            },
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../models/stock.dart';
import '../services/FavoriteService.dart';
import 'company_details.dart';

class SearchResultsPage extends StatefulWidget {
  final List<Stock> data;

  const SearchResultsPage({super.key, required this.data});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  late List<Stock> stocks;

  @override
  void initState() {
    super.initState();
    stocks = widget.data;
    _syncFavorites();
  }

  Future<void> _syncFavorites() async {
    final favorites = await FavoritesService.getFavorites();
    setState(() {
      for (var stock in stocks) {
        stock.isFavorite = favorites.contains(stock.symbol);
      }
    });
  }

  void toggleFavorite(int index) async {
    final stock = stocks[index];
    await FavoritesService.toggleFavorite(stock.symbol);
    setState(() {
      stock.isFavorite = !stock.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Results")),

      body: ListView.builder(
        itemCount: stocks.length,
        itemBuilder: (context, index) {
          final stock = stocks[index];

          return ListTile(
            title: Text(stock.name),
            subtitle: Text("${stock.symbol} • ${stock.country}"),

            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("\$${stock.price.toStringAsFixed(2)}"),

                const SizedBox(width: 10),

                IconButton(
                  icon: Icon(
                    stock.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: stock.isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () => toggleFavorite(index),
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
              ).then((_) => _syncFavorites());
            },
          );
        },
      ),
    );
  }
}

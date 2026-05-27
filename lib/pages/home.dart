import 'package:flutter/material.dart';
import '../models/stock.dart';
import '../services/FavoriteService.dart';
import '../services/StockService.dart';
import '../widgets/company_search_widget.dart';
import 'company_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StockService _stockService = StockService();
  List<Stock> _topStocks = [];

  @override
  void initState() {
    super.initState();
    _loadTopStocks();
  }

  void _loadTopStocks() async {
    final stocks = await _stockService.getTopGainers();
    final favorites = await FavoritesService.getFavorites();

    for (var stock in stocks) {
      stock.isFavorite = favorites.contains(stock.symbol);
    }

    setState(() {
      _topStocks = stocks;
    });
  }

  void _syncFavorites() async {
    final favorites = await FavoritesService.getFavorites();

    setState(() {
      for (var stock in _topStocks) {
        stock.isFavorite = favorites.contains(stock.symbol);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stox")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CompanySearchWidget(),
            const SizedBox(height: 20),
            const Text(
              "Top Gainers",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _topStocks.isEmpty
                  ? const Center(child: Text("No top stocks available"))
                  : ListView.builder(
                itemCount: _topStocks.length,
                itemBuilder: (context, index) {
                  final stock = _topStocks[index];
                  return ListTile(
                    title: Text(stock.name),
                    subtitle: Text("${stock.symbol} • ${stock.country}"),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${stock.price.toStringAsFixed(2)}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "+${stock.percentChange.toStringAsFixed(2)}%",
                          style: const TextStyle(color: Colors.green, fontSize: 12),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompanyDetailsPage(stock: stock),
                        ),
                      ).then((_) => _syncFavorites());
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
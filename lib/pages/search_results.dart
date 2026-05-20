import 'package:flutter/material.dart';
import '../models/stock.dart';
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
  }

  void toggleFavorite(int index) {
    setState(() {
      stocks[index].isFavorite = !stocks[index].isFavorite;
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
              );
            },
          );
        },
      ),
    );
  }
}
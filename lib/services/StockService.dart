import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:stox/models/stock.dart';

class StockService {

  Future<List<Stock>> loadStocks() async {
    final String jsonString = await rootBundle.loadString('assets/stocks.json');

    final List<dynamic> jsonData = json.decode(jsonString);

    return jsonData.map((e) => Stock.fromJson(e)).toList();
  }

  Future<List<Stock>> search(String query) async {
    final stocks = await loadStocks();
    final lowerQuery = query.toLowerCase();

    final List<Stock> results = [];

    for (final stock in stocks) {
      final name = stock.name.toLowerCase();
      final symbol = stock.symbol.toLowerCase();
      final sector = stock.sector.toLowerCase();
      final country = stock.country.toLowerCase();

      if (name.contains(lowerQuery) ||
          symbol.contains(lowerQuery) ||
          sector.contains(lowerQuery) ||
          country.contains(lowerQuery)) {
        results.add(stock);
      }
    }

    return results;
  }

  Future<List<Stock>> getTopGainers() async {
    final stocks = await loadStocks();
    
    stocks.sort((a, b) => b.percentChange.compareTo(a.percentChange));
    
    return stocks.take(5).toList();
  }

}

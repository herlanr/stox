import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:stox/models/stock.dart';

class StockService {
  Future<List<Stock>> loadStocks() async {
    final jsonString = await rootBundle.loadString('assets/stocks.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((e) => Stock.fromJson(e)).toList();
  }

  Future<List<Stock>> search(String query) async {
    final stocks = await loadStocks();
    final q = query.toLowerCase();

    return stocks.where((s) => 
      [s.name, s.symbol, s.sector, s.country].any((f) => f.toLowerCase().contains(q))
    ).toList();
  }

  Future<List<Stock>> getTopGainers() async {
    final stocks = await loadStocks();
    stocks.sort((a, b) => b.percentChange.compareTo(a.percentChange));
    return stocks.take(5).toList();
  }
}

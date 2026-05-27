import 'package:flutter/material.dart';
import 'package:stox/services/StockService.dart';

import '../pages/search_results.dart';

class CompanySearchWidget extends StatefulWidget {
  @override
  _CompanySearchWidgetState createState() => _CompanySearchWidgetState();
}

class _CompanySearchWidgetState extends State<CompanySearchWidget> {

  final TextEditingController _controller = TextEditingController();
  final StockService stockService = StockService();

  void searchCompany() async {
    final text = _controller.text;

    final results = await stockService.search(text);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsPage(data: results),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: "Search company...",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSubmitted: (_) => searchCompany(), // Enter gedrückt
        );

  }
}
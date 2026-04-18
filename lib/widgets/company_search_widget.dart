import 'package:flutter/material.dart';

class CompanySearchWidget extends StatefulWidget {
  @override
  _CompanySearchWidgetState createState() => _CompanySearchWidgetState();
}

class _CompanySearchWidgetState extends State<CompanySearchWidget> {
  final TextEditingController _controller = TextEditingController();

  void searchCompany() {
    final text = _controller.text;
    print("Search parameter = $text");

    // api.searchCompanies(text);
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
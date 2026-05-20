import 'package:flutter/material.dart';
import '../widgets/company_search_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stox"),
      ),
      body: Padding(
        //16 pixels of empty space INSIDE the widget on all sides
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CompanySearchWidget()
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'company_details.dart';
import '../widgets/company_search_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, String>> topCompanies = const [
    {"name": "Apple", "symbol": "AAPL"},
    {"name": "Microsoft", "symbol": "MSFT"},
    {"name": "Amazon", "symbol": "AMZN"},
    {"name": "Alphabet (Google)", "symbol": "GOOGL"},
    {"name": "Tesla", "symbol": "TSLA"},
  ];

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
            CompanySearchWidget(),

            const SizedBox(height: 20),

            Text(
              "Top Highlighted Companies",
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: topCompanies.length,
                itemBuilder: (context, index) {
                  final company = topCompanies[index];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(company["symbol"]![0]),
                      ),
                      title: Text(company["name"]!),
                      subtitle: Text(company["symbol"]!),
                      trailing: const Icon(Icons.arrow_forward, size: 16),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompanyDetailsPage(
                              name: company["name"]!,
                              symbol: company["symbol"]!,
                            ),
                          ),
                        );
                      },
                    ),
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
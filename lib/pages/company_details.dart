import 'package:flutter/material.dart';
import '../models/stock.dart';
import '../widgets/info_row.dart';

class CompanyDetailsPage extends StatefulWidget {
  final Stock stock;

  const CompanyDetailsPage({
    super.key,
    required this.stock,
  });

  @override
  State<CompanyDetailsPage> createState() => _CompanyDetailsPageState();
}

class _CompanyDetailsPageState extends State<CompanyDetailsPage> {

  late Stock stock;

  @override
  void initState() {
    super.initState();
    stock = widget.stock;
  }

  void toggleFavorite() {
    setState(() {
      stock.isFavorite = !stock.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPositive = stock.change >= 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(stock.name),
        actions: [
          IconButton(
            icon: Icon(
              stock.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: stock.isFavorite ? Colors.red : null,
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),


      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              stock.symbol,
              style: Theme.of(context).textTheme.displayMedium,
            ),

            const SizedBox(height: 10),

            Text(
              "\$${stock.price.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Icon(
                  isPositive
                      ? Icons.trending_up
                      : Icons.trending_down,
                  color: isPositive ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 6),
                Text(
                  "${stock.change} (${stock.percentChange}%)",
                  style: TextStyle(
                    color: isPositive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),

            const SizedBox(height: 20),

            const Divider(),

            const SizedBox(height: 10),

            InfoRow(label: "Exchange", value: stock.exchange),
            InfoRow(label: "Currency", value: stock.currency),
            InfoRow(label: "Sector", value: stock.sector),
            InfoRow(label: "Country", value: stock.country),
          ],
        ),
      ),
    );
  }
}

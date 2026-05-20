class Stock {
  final String symbol;
  final String name;
  final String exchange;
  final String currency;
  final double price;
  final double change;
  final double percentChange;
  final String sector;
  final String country;

  bool isFavorite;

  Stock({
    required this.symbol,
    required this.name,
    required this.exchange,
    required this.currency,
    required this.price,
    required this.change,
    required this.percentChange,
    required this.sector,
    required this.country,
    this.isFavorite = false
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      symbol: json['symbol'],
      name: json['name'],
      exchange: json['exchange'],
      currency: json['currency'],
      price: (json['price'] as num).toDouble(),
      change: (json['change'] as num).toDouble(),
      percentChange: (json['percent_change'] as num).toDouble(),
      sector: json['sector'],
      country: json['country'],
    );
  }
}
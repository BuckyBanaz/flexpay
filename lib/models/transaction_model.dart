class TransactionModel {
  final String title;
  final String image;
  final String date;
  final double amount;
  final String? subtitle;

  TransactionModel({
    required this.title,
    required this.image,
    required this.date,
    required this.amount,
    this.subtitle,
  });
}

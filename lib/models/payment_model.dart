class PaymentModel {
  final DateTime date;
  final String fromWhom;
  final String type;
  final double amount;
  final String description;

  PaymentModel({
    required this.date,
    required this.fromWhom,
    required this.type,
    required this.amount,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'fromwhom': fromWhom,
      'type': type,
      'amount': amount,
      'description': description,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> json) => new PaymentModel(
      fromWhom: json['fromwhom'],
      description: json['description'],
      type: json['type'],
      amount: json['amount'],
      date: DateTime.parse(json['date']));
}

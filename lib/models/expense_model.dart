class ExpenseModel {
  final String expenseName;
  final DateTime date;
  final String type;
  final double amount;
  final String paidTo;

  ExpenseModel({
    required this.expenseName,
    required this.date,
    required this.type,
    required this.amount,
    required this.paidTo,
  });

  Map<String, dynamic> toMap() {
    return {
      'expensename': expenseName,
      'date': date.toIso8601String(),
      'type': type,
      'amount': amount,
      'paidto': paidTo,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> json) => new ExpenseModel(
        expenseName: json['expensename'],
        date: DateTime.parse(json['date']),
        type: json['type'],
        amount: json['amount'],
        paidTo: json['paidto'],
      );
}

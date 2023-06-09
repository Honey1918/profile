import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final newDate = DateFormat.yMd();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense(
      {required this.amount,
      required this.date,
      required this.title,
      required this.category})
      : id = uuid.v4();

  final String title;
  final DateTime date;
  final String id;
  final double amount;
  final Category category;

  String get formatedDate {
    return newDate.format(date);
  }
  /*
  IconData get categoryIcon {
    switch (category) {
      case Category.food:
        return Icons.lunch_dining;
      case Category.travel:
        return Icons.flight_takeoff;
      case Category.leisure:
        return Icons.movie;
      case Category.work:
        return Icons.work;
      default:
        return Icons.error;
    }
  }
  */
}

class Expensebucket {
  Expensebucket({required this.category1, required this.expense2});

  Expensebucket.forCategory(List<Expense> allexpense, this.category1)
      : expense2 = allexpense
            .where((expense) => expense.category == category1)
            .toList(); // Additional constructor function
  final List<Expense> expense2;
  final Category category1;

  double get totalExpense {
    double sum = 0;

    for (final expense in expense2) {
      sum += expense.amount;
    }
    return sum;
  }
}

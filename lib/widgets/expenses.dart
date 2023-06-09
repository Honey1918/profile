import 'package:expense_tracker/widgets/chart/char.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expenselist.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _Expensestate();
  }
}

class _Expensestate extends State<Expenses> {
  final List<Expense> _registerdata = [
    Expense(
        amount: 50,
        date: DateTime.now(),
        title: 'Club',
        category: Category.leisure),
    Expense(
        amount: 30,
        date: DateTime.now(),
        title: 'Cinema',
        category: Category.work),
  ];

  void _openAddExpense() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => New_Expense(
              onAddexpense: _addExpense,
            ),
            );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registerdata.add(expense);
    });
  }

  void _removeexpense(Expense expense) {
    final indexexpense = _registerdata.indexOf(expense);
    setState(() {
      _registerdata.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registerdata.insert(indexexpense, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    Widget maincontent = const Center(
      child: Text('No expenses here, Start adding some!'),
    );

    if (_registerdata.isNotEmpty) {
      maincontent = Expenselist(
        expenselist1: _registerdata,
        onRemoved: _removeexpense,
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My ExpenseTracker'), actions: [
        IconButton(
          onPressed: _openAddExpense,
          icon: const Icon(Icons.add),
        )
      ]),
      body: w < h
          ? Column(
              children: [
                Chart(expenses: _registerdata),
                Expanded(
                  child: maincontent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registerdata)),
                Expanded(
                  child: maincontent,
                ),
              ],
            ),
    );
  }
}

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expenseitem.dart';
import 'package:flutter/material.dart';

class Expenselist extends StatelessWidget {
  const Expenselist(
      {super.key, required this.expenselist1, required this.onRemoved});

  final List<Expense> expenselist1;
  final void Function(Expense expense) onRemoved;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenselist1.length,
      itemBuilder: (ctx, idx) => Dismissible(
        key: ValueKey(expenselist1[idx]),
        background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.85),
            margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal)),
        onDismissed: (direction) {
          onRemoved(expenselist1[idx]);
        },
        child: Expenseitems(expenselist1[idx]),
      ),
    );
  }
}

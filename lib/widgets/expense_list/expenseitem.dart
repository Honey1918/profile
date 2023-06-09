import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenseitems extends StatelessWidget {
  const Expenseitems(this.expenseitem, {super.key});
  final Expense expenseitem;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            expenseitem.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Text('\$${expenseitem.amount.toStringAsFixed(2)}'),
              const Spacer(),
              Row(
                children: [
                 Icon(categoryIcons[expenseitem.category]),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(expenseitem.formatedDate),
                ],
              ),
            ],
          )
        ],
      ),
    ));
  }
}

import 'package:expensetrack/widget/expense_list/expense_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key,required this.expense,required this.onRemoveExpense});

  final List<Expense> expense;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
    itemCount: expense.length,
    itemBuilder: (ctx,index)=>Dismissible(
      background: Container(color: Theme.of(context).colorScheme.error.withOpacity(0.75),
      margin: EdgeInsets.symmetric(horizontal:  Theme.of(context).cardTheme.margin!.horizontal,
      ),
      ),
        key: ValueKey(expense[index]),
        onDismissed: (direction){
          onRemoveExpense(expense[index]);
        },
        child: ExpenseItem(expense: expense[index])),);
  }
}

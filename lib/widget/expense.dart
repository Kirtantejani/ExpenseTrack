import 'package:expensetrack/widget/chart/chart.dart';
import 'package:expensetrack/widget/expense_list/expense_list.dart';
import 'package:expensetrack/widget/new_expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {

  final List<Expense> _registerExpense=[
    Expense(title: 'Flutter', amount: 19.99, date: DateTime.now(), category: Category.food),
    Expense(title: 'Cinema', amount: 15.99, date: DateTime.now(), category: Category.leisure),

  ];


   void _openAddExpenseOverlay(){

     showModalBottomSheet(useSafeArea: true,isScrollControlled: true,context: context, builder: (ctx)=> NewExpense(onAddExpense: _addExpense), );

   }

   void _addExpense(Expense expense){
     setState(() {
       _registerExpense.add(expense);
     });
   }

   void _removeExpense(Expense expense){
     final expenseIndex=_registerExpense.indexOf(expense);
     setState(() {
       _registerExpense.remove(expense);
     });
     ScaffoldMessenger.of(context).clearSnackBars();
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
       duration: Duration(seconds: 3),
       content: const Text('Expense deleted.'),
         action: SnackBarAction(
           label: 'Undo',
           onPressed: (){
             setState(() {
               _registerExpense.insert(expenseIndex,expense);
             });
           },
         ),
       ),

     );
   }
  @override
  Widget build(BuildContext context) {
    final width= MediaQuery.of(context).size.width;
     Widget mainContent=const Center(child: Text('No expense found.Start adding some!'),);

     if(_registerExpense.isNotEmpty){
       mainContent=ExpenseList(expense: _registerExpense,onRemoveExpense: _removeExpense,);
     }
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(onPressed: (){_openAddExpenseOverlay();}, icon: const Icon(Icons.add))
        ],
      ),
      body: width <= 600 ? Column(
        children:  [
          Chart(expenses: _registerExpense),
          Expanded(child:mainContent,
          ),
        ],
      ):Row(
        children:  [
          Expanded(child: Chart(expenses: _registerExpense)),
          Expanded(child:mainContent,
          ),
        ],

      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class New_Expense extends StatefulWidget {
  const New_Expense({super.key, required this.onAddexpense});
  final Function(Expense expense) onAddexpense;
  @override
  State<StatefulWidget> createState() {
    return _Newexpense();
  }
}

class _Newexpense extends State<New_Expense> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime? _selecteddate;
  Category _selectedcategory = Category.food;

  void _presentdatepicker() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 1, now.month, now.day);
    final pickeddate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstdate,
        lastDate: now);
    //Await keyboard has been used to tell the value has not used initially but in future

    setState(() {
      _selecteddate = pickeddate;
    });
  }
  void _showdialog(){
    if(Platform.isIOS){
      showCupertinoDialog(context: context, builder:(ctx) => CupertinoAlertDialog(
        title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was Entered'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
      ),);
    }
    else{
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was Entered'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  void _submitExpensedata() {
    final enteredAmount = double.tryParse(_amountcontroller
        .text); // tryPrase('hellow') return null and of('1.12') return 1.12
    final amountisInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titlecontroller.text.trim().isEmpty || amountisInvalid) {
      //showing error message
      _showdialog();
      return;
    }
    widget.onAddexpense(Expense(
        amount: enteredAmount,
        date: _selecteddate!,
        title: _titlecontroller.text,
        category: _selectedcategory));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardspace = MediaQuery.of(context)
        .viewInsets
        .bottom; //veiwInsect has informaion regarding UI elements that takes certain amount of spaces
        
    return LayoutBuilder(builder: (ctx, constraints) {
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, 16 + keyBoardspace),
            child: Column(children: [
                TextField(
                 controller: _titlecontroller,
                  maxLength: 50,
                  decoration: const InputDecoration(label: Text('Title')),
                ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountcontroller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          prefixText: '\$', label: Text('Amount')),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_selecteddate == null
                            ? 'No date selected'
                            : newDate.format(_selecteddate!)),
                        IconButton(
                            onPressed: () {
                              _presentdatepicker();
                            },
                            icon: const Icon(Icons.calendar_month)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  DropdownButton(
                    value: _selectedcategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedcategory = value;
                      });
                    },
                  ),
                  const Spacer(),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: _submitExpensedata,
                    child: const Text('Save Expense'),
                  )
                ],
              )
            ]),
          ),
        ),
      );
    });
  }
}

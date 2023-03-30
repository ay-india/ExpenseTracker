import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime? _selectedDate;
  void _submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredAmount <= 0 || enteredTitle.isEmpty || _selectedDate == null) {
      return; //if this condition satisfy then code with not execute to next line.
    } // return stops the function execution.

    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    //using widget.addTx we can get access to properties & method of widget class inside of state class
    Navigator.of(context)
        .pop(); // on pressing tick button in keyboard it closes the pop window
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            // decoration: InputDecoration(labelText: 'Title'),
            controller: titleController,
            onSubmitted: (_) =>
                _submitData(), //anonymous fn is just as reference to onSubmitted.
          ),
          TextField(
            // decoration: InputDecoration(labelText: 'Amount'),
            controller: amountController,
            keyboardType: TextInputType
                .number, //this make amount coloumn to only input in number.
            onSubmitted: (_) =>
                _submitData(), //just want to pass pointer so that we use anonymous function .
            // Anonymous function have string argument so we give '_' as argument. we don't want to use it
          ),
          Container(
              height: 81,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date choosen'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}'),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )),
          ElevatedButton(
            child: Text(
              'Add Transaction',
            ),

            // color: Theme.of(context).primaryColor,
            //textColor: Theme.of(context).textTheme.button.color,
            //check the above line

            onPressed:
                _submitData, //we just passed the reference of our own function.
          ),
        ]),
      ),
    );
  }
}

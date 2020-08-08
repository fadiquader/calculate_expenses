import 'package:calculate_expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransactionForm extends StatefulWidget {
  final Function addTransaction;

  NewTransactionForm({
    this.addTransaction,
  });

  @override
  _NewTransactionFormState createState() => _NewTransactionFormState();
}

class _NewTransactionFormState extends State<NewTransactionForm> {
  DateTime _selectedDate = DateTime.now();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _showDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()
    ).then((value) {
      if (value == null) {
        return;
      }
      setState((){
        _selectedDate = value;
      });
    });
  }

  void _submitTransaction() {
    if (_titleController.text.isEmpty) return;
    if (_amountController.text.isEmpty) return;
    widget.addTransaction(
        Transaction(
          title: _titleController.text,
          amount: double.parse(_amountController.text),
          date: _selectedDate,
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.done,
                controller: _titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
                controller: _amountController,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                          'Picked date: ${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text('Choose Date'),
                      onPressed: _showDatePicker,
                    )
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton.icon(
                  onPressed: _submitTransaction,
                  icon: Icon(Icons.add),
                  label: Text(
                    'Add Transaction',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  padding: EdgeInsets.symmetric(vertical: 12,),
                ),
              )
            ],
          )),
    );
  }
}

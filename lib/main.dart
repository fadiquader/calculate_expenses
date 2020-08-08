import 'package:calculate_expenses/widgets/chart.dart';
import 'package:calculate_expenses/widgets/new-transaction-form.dart';
import 'package:calculate_expenses/widgets/transaction-list.dart';
import 'package:flutter/material.dart';
import 'package:calculate_expenses/models/transaction.dart';

void main() {
  runApp(MyApp());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.orangeAccent,
        fontFamily: 'Quicksand',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          button: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
         textTheme:  ThemeData.light().textTheme.copyWith(
             headline6: TextStyle(
             fontFamily: 'OpenSans',
             fontSize: 20,
             fontWeight: FontWeight.bold,
           )
         )
        ),
      ),
      home: MyHomePage(title: 'Personal Expenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _transactions = [
    Transaction(
      title: 'Test Tx',
      amount: 6.4,
      date: DateTime.now(),
    ),
  ];

  void _addTransaction(Transaction tx) {
    setState(() {
//      _transactions.insert(0, tx);
      _transactions.add(tx);
    });
    Navigator.of(context).pop();
  }
  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  void _showDeleteAlertDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Notice"),
          content: Text("Confirm delete?"),
          actions: [
            FlatButton(
              child: Text("Cancel"),
              textColor: Colors.black,
              onPressed:  () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
//              textColor: Colors.red,
              child: Text("Delete"),
              onPressed:  () {
                this._deleteTransaction(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _startNewTransaction() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            behavior: HitTestBehavior.opaque,
            child: NewTransactionForm(addTransaction: this._addTransaction,),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Chart(_transactions),
            TransactionList(
              transactions: _transactions,
              deleteTransaction: _showDeleteAlertDialog,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
        onPressed: _startNewTransaction,
      ),
    );
  }

}

import 'package:calculate_expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList({
    this.transactions,
    this.deleteTransaction,
  });
  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32),
            child: Text('No transactions added yet!',),
          ),
//          SizedBox(
//            height: 20,
//          ),
          Container(
              height: 200,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              )),
        ],
      );
    }

    return Container(
      height: 300,
      child: ListView.builder(
          itemBuilder: (ctx, index) {
            var tx = transactions[index];
            return Card(
              elevation: 3,
              margin: EdgeInsets.all(16),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: FittedBox(
                      child: Text('${tx.amount}'),
                    ),
                  ),
                ),
                title: Text(tx.title, style: Theme.of(context).textTheme.headline6,),
                subtitle: Text('${DateFormat.yMMMd().format(tx.date)}'),
                trailing: IconButton(
                  color: Colors.red,
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deleteTransaction(tx.id);
                  },
                ),
              ),
            );
          },
        itemCount: transactions.length,
      )
      ,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;
  TransactionList(this.transaction, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      child: (transaction.isEmpty)
          ? Column(children: [
              Text("No transaction found!",
                  style: Theme.of(context).textTheme.headline6),
              SizedBox(height: 18),
              Container(
                height: 150,
                child:
                    Image.asset("assets/images/waiting.png", fit: BoxFit.cover),
              ),
            ])
          : ListView.builder(
              itemBuilder: (ctx, index) {
                /*return Card(
                    child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(9),
                      margin: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 10.0,
                      ),
                      child: Text(
                        '₹${transaction[index].amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                          color: Theme.of(context).primaryColor,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 3,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(2),
                          child: Text(
                            transaction[index].title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(2),
                          child: Text(
                            DateFormat().format(transaction[index].date),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ));*/
                //alternative to above code
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 5.0,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${transaction[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transaction[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(
                        transaction[index].date,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTx(transaction[index].id),
                    ),
                  ),
                );
              },
              itemCount: transaction.length,
            ),
    );
  }
}

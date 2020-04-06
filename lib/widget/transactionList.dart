import 'package:expense_calculator/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);

 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 620,
      padding: EdgeInsets.symmetric(horizontal: 5),
          child: transactions.isEmpty ? Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              Text('No transactions added yet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              Padding(padding: EdgeInsets.symmetric(vertical: 50)),
              Container(
                height: 200,
                child: Image.asset('assets/image/waiting.png', fit: BoxFit.fill,))
            ],
          ): ListView.builder(
            itemBuilder: (ctx, index){
              return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                            style: BorderStyle.solid
                          )
                        ), 
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Rs ${transactions[index].amount.toStringAsFixed(2)}', 
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
                      ),
                      
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(transactions[index].title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                          Text(DateFormat.yMMMMEEEEd().format(transactions[index].date) , style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 10),),
                        ],
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 45)),
                      Column(
                        children: <Widget>[
                          Icon(Icons.delete, color: Colors.red,)
                        ],
                        ),
                    ],
                  ),
                );
            },
            itemCount: transactions.length, 
            ),
    );
  }
}
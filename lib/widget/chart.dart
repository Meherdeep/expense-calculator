import 'package:expense_calculator/models/transaction.dart';
import 'package:expense_calculator/widget/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String,Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index),);
      double totalSum = 0.0;
      for(var i=0;i<recentTransactions.length;i++){
        if (recentTransactions[i].date.day == weekDay.day && 
        recentTransactions[i].date.month == weekDay.month &&
        recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      print('day: $DateFormat.E().format(weekDay)'+'amount: $totalSum');
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    });
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum,item){
      return sum+item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
              child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
            children: groupedTransactionValues.map((data){
              // return Text('${data['day']} : ${data['amount']} ');
              final myDailySpendingLimit = 1000;
              return ChartBar(data['day'], data['amount'], (data['amount'] as double) / myDailySpendingLimit);
            }).toList()
          ),
      ),
      
    );
  }
}
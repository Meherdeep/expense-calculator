import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitData(){
    final expenseTitle = titleController.text;
    final expenseAmount = double.parse(amountController.text);
    
    if (expenseTitle.isEmpty || expenseAmount<0 || selectedDate==null) {
      return;
    } 
    widget.addTx(expenseTitle, expenseAmount, selectedDate);
    Navigator.of(context).pop();
  }
  void submitDate(){
    showDatePicker(
      context: context, initialDate: DateTime.now(), firstDate: DateTime(1998), lastDate: DateTime.now()
      ).then((pickedDate){
        if (pickedDate == null) {
          return;
        }
        setState(() {
          selectedDate = pickedDate;  
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  TextField(
                    controller: titleController,
                    onSubmitted: (_) => submitData,
                    decoration: InputDecoration(
                      labelText: 'Item Name',
                      hintText: 'Grocery',
                      focusColor: Colors.blue,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 3,
                          style: BorderStyle.solid
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      icon: Icon(Icons.add_shopping_cart)
                    ) ,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  TextField(
                    controller: amountController,
                    onSubmitted: (_) => submitData,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      hintText: '100',
                      focusColor: Colors.blue,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      icon: Icon(Icons.attach_money),
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.calendar_today), onPressed: submitDate),
                      Container(
                        width: 335,
                        height: 60,
                        padding: EdgeInsets.only(left: 10,top: 20),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black38),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(selectedDate == null ? 'dd/mm/yyyy' : DateFormat.yMd().format(selectedDate),
                        textAlign: TextAlign.justify,
                        style: selectedDate == null ? TextStyle(color: Colors.black38, fontSize: 15,) : TextStyle(color: Colors.black, fontSize: 17),),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  FlatButton(
                    onPressed: submitData, 
                    child: Text('Add Transaction'),
                    textColor: Colors.white,
                    color: Colors.blue,
                  )
                ],
              ),
            ),
          );
  }
}
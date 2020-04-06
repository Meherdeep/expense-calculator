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
  var selectedDate = TextEditingController();

  void submitData(){
    final expenseTitle = titleController.text;
    final expenseAmount = double.parse(amountController.text);
    
    if (expenseTitle.isEmpty || expenseAmount<0) {
      return;
    } 
    widget.addTx(expenseTitle, expenseAmount);
    Navigator.of(context).pop();
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
                  TextField(
                    autofocus: false,
                    //keyboardType: TextInputType.datetime,
                    onTap: (){
                      showDatePicker(
                        context: context, 
                        initialDate: DateTime.now(), 
                        firstDate: DateTime(1998), 
                        lastDate: DateTime.now()
                      ).then((pickedDate) {
                        if(pickedDate == null){
                          return;
                        }
                        setState(() {
                          selectedDate = pickedDate as TextEditingController;  
                        });
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Date',
                      hintText: 'dd/mm/yyyy',
                      focusColor: Colors.blue,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 3,
                        ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    icon: Icon(Icons.calendar_today),
                  ),
                  controller: selectedDate,
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
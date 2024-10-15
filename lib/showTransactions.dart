import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transactions.dart';
class ShowTransaction extends StatelessWidget {
  List<Transactions> transaction;
  Function deletetrans;
  ShowTransaction(this.transaction,this.deletetrans);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx,constraints){
      return Container(height: constraints.maxHeight,child: transaction.isEmpty ? Column(children: <Widget>[Text("No Item")],) :
      ListView.builder(itemBuilder : (ctx,index){
        return Card(color:Color(0xfffe1ecf7) 
        
        ,margin: EdgeInsets.symmetric(vertical: 5,horizontal: 8),elevation: 5,
                  child: ListTile(leading: Container(width: 110,alignment: AlignmentDirectional(0, 0),child: Text("Rs ${transaction[index].amount}",style: TextStyle(color: Colors.red,fontSize: 20,fontWeight:FontWeight.bold),),
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(25),border:Border.all(color:Colors.redAccent,width: 2)),
                 padding:EdgeInsets.all(2),
                  margin: EdgeInsets.all(5), ),
          title: Text(transaction[index].title,style: TextStyle(color: Color(0xff2d386b),fontSize:15,fontWeight:FontWeight.bold),),
          subtitle: Text(DateFormat("dd-MM-yyyy").format(transaction[index].date)),
          trailing: IconButton(color: Colors.red,icon: Icon(Icons.delete), onPressed: (){deletetrans(transaction[index].id);}),),
        );
    
    },
    itemCount: transaction.length,
    )
    );
    },);
    
      
  }
}
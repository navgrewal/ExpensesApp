import './chartbar.dart';
import 'package:flutter/material.dart';
import './transactions.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  List<Transactions> trans;
  Chart(this.trans);
  List<Map<String ,Object>> get groupedTransaction{
    return List.generate(7, (index){
      final weekday = DateTime.now().subtract(Duration(days: index));
      var total =0;
      for (var i=0;i<trans.length;i++){
        if (trans[i].date.day == weekday.day && trans[i].date.month == weekday.month && trans[i].date.year==weekday.year){
          total =total + trans[i].amount;
        }
      } 
      print(DateFormat.E().format(weekday));    
      print(total);
      return {"day":DateFormat.E().format(weekday),"amount":total};
    }).reversed.toList();
  }
  int get totalamt{
    return groupedTransaction.fold(0, (sum,item){
      return sum + item["amount"];
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(margin: EdgeInsets.only(bottom: 5,top:5,left: 2,right: 2),
      child: Card(elevation: 5,color: Color(0xfffe1ecf7) //Color.fromRGBO(90, 90, 90, 1)
      ,      child: Padding(padding: EdgeInsets.all(5),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: 
            groupedTransaction.map((data){return Flexible(fit: FlexFit.tight,child: Chartbar(data["day"], data["amount"],totalamt==0 ? 0 :(data["amount"] as int)/totalamt));}).toList(),
          
          ),
        ),
      ),
    );
  }
}